#!/bin/bash
# 使用tput定义颜色
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)
# # 使用示例
# echo "GREEN错误信息RESET"
# echo "RED成功信息RESET"

# status
OK="${GREEN}[ok] "
ERROR="${RED}[err] "

main() {
  local SCRIPT_DIR="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
  local NVIM_DIR="$HOME/.config/nvim"
  if [[ -d $HOME/.config/nvim.bak ]]; then
    rm -rf $HOME/.config/nvim.bak
  fi
  mv $NVIM_DIR $HOME/.config/nvim.bak
  if [[ ! -d $NVIM_DIR ]]; then
    mkdir $NVIM_DIR
  fi
  cp -r * $NVIM_DIR
  echo "${OK}neovim is updated!!!"
}
main
