#!/bin/sh
# 新しくセッション、ウィンドウ、ペインが作られたことの区切りを記録する
s="$1"
i="$2"
p="$3"

dir="$HOME/.tmux/log"
now=`date +"%Y/%m/%d-%H:%M:%S.%N"`
ymd=`echo "$now" | sed 's|\([0-9]*\)/\([0-9]*\)/\([0-9]*\)-.*|\1\2\3|g'`

echo "=== Session:$s Window:$i Pane:$p ===" >> "${dir}/${ymd}_${s}.${i}.${p}.log"
