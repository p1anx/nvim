
cmake_minimum_required(VERSION 3.16)
project(myProject)

if(NOT CMAKE_BUILD_TYPE)
  set(default_build_type "Debug")
  message(STATUS "Set the build type to `${default_build_type}` as none was specified.")
  set(CMAKE_BUILD_TYPE ${default_build_type} CACHE STRING "Chooce the build type." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
  "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()
message(STATUS "myProject Build Type: ${CMAKE_BUILD_TYPE}")

# Set the version for myProject
set(myProject_Version_Major 0)
set(myProject_Version_Minor 1)
set(myProject_Version_Patch 0)
set(myProject_Version_Status "-dev")
set(PROJECT_VERSION
  "${myProject_Version_Major}.${myProject_Version_Minor}.${myProject_Version_Patch}${myProject_Version_Status}"
)
message(STATUS "${PROJECT_NAME} version: ${PROJECT_VERSION}")



#================config options================
set(UPLOAD_TOOL "jlink") #options: jlink, cmsis-dap
set(SWD_JTAG_PORT "swd") #options: swd, jtag
set(TARGET_MCU "stm32f1x") #options: stm32f1x, stm32f4x, stm32f7x, stm32h7x, and so on
#==============================================

# 查找必要的工具
find_program(OPENOCD /usr/bin/openocd)
find_program(GDB arm-none-eabi-gdb)
find_program(KILL pkill)  # Linux/macOS
# 对于 Windows 使用 taskkill
if(WIN32)
  find_program(KILL taskkill)
endif()
# Set upload command based on the selected tool
if(UPLOAD_TOOL STREQUAL "jlink")
  set(INTERFACE_CFG "interface/jlink.cfg")
elseif(UPLOAD_TOOL STREQUAL "cmsis-dap")
  set(INTERFACE_CFG "interface/cmsis-dap.cfg")
endif()

add_custom_target(flash
COMMAND ${OPENOCD}
  -f ${INTERFACE_CFG}
  -c "transport select ${SWD_JTAG_PORT}"
  -f target/${TARGET_MCU}.cfg
  -c "program ${CMAKE_PROJECT_NAME}.elf verify reset exit"
DEPENDS ${CMAKE_PROJECT_NAME}.elf  # 依赖目标文件，确保先编译
COMMENT "Flashing ${CMAKE_PROJECT_NAME}.elf with OpenOCD"
)
add_dependencies(flash ${CMAKE_PROJECT_NAME})
# 自定义目标：启动调试会话
add_custom_target(start_openocd
COMMAND ${OPENOCD}
  -f ${INTERFACE_CFG}
  -c "transport select swd"
  -f target/${TARGET_MCU}.cfg
  -c "gdb_port 3333"
  -c "tcl_port 6667"
  -c "telnet_port 4445"
  > openocd.log 2>&1 &
)
#================debug stm32 command================
add_custom_target(debug
COMMAND ${GDB} ${CMAKE_PROJECT_NAME}.elf
  -ex "target extended-remote :3333"
  -ex "monitor reset halt"
  -ex "load"
  -ex "break main"
  -ex "continue"
  USES_TERMINAL
COMMAND ${KILL} -f openocd 2> /dev/null
COMMENT "Closing openocd server.."
)
add_dependencies(debug start_openocd)
