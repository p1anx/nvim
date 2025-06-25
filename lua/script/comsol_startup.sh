#!/bin/bash

# 检查是否传递了 .m 文件名
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename.m>"
  exit 1
fi

# 获取 .m 文件名
FILE=$1

# 检查文件是否存在
# if [ ! -f "$FILE" ]; then
#   echo "File $FILE does not exist."
#   exit 1
# fi

# 启动 MATLAB 并运行指定的 .m 文件

# 设置要查找和关闭的端口号
PORT=2036

# 使用lsof命令查找占用指定端口的进程ID
PID=$(lsof -t -i:$PORT)

if [ -n "$PID" ]; then
  echo "Found process ID $PID using port $PORT. Killing process..."
  kill $PID
  if [ $? -eq 0 ]; then
    echo "Process $PID killed successfully."
  else
    echo "Failed to kill process $PID."
  fi
else
  echo "Port $PORT is not in use."
fi
# if command -v "comsol server"; then
comsol mphserver &
# matlab -nodesktop -nosplash -r 'mphstart("127.0.0.1", 2036, "root", "xwjs"); $FILE'
# matlab -nodesktop -nosplash -r 'test; disp("this is ok"); exit;'
matlab -nodesktop -nosplash -r "mphstart('127.0.0.1', 2036, 'root', 'xwjs'); run('$FILE'); exit;"
