#!/bin/sh
msg="$1"
s="$2"
i="$3"
p="$4"

dir="$HOME/.tmux/log"
now=`date +"%Y/%m/%d-%H:%M:%S.%N"`
ymd=`echo "$now" | sed 's|\([0-9]*\)/\([0-9]*\)/\([0-9]*\)-.*|\1\2\3|g'`

echo "[${now}] ${msg}" >> "${dir}/${ymd}_${s}.${i}.${p}.log"
