#!/bin/bash
# 检查是否传递了 .m 文件名
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename.m>"
  exit 1
fi
FILE=$1
matlab -nodesktop -nosplash -r "run('$FILE'); exit;"
