#!/bin/bash
main() {
  local SCRIPT_DIR="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
  local NVIM_DIR=$HOME/.config/nvim
  mv $NVIM_DIR $HOME/.config/nvim.bak
  if [[ ! -d $NVIM_DIR ]]; then
    mkdir $NVIM_DIR
  fi
  cp -r * $NVIM_DIR
  echo "neovim is updated!!!"
}
main
