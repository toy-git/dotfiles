#!/bin/sh
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create symlink (~/.tmux.conf)
#
tmux_conf="$HOME/.tmux.conf"
if [ -e "$tmux_conf" ]; then
  echo "move: $tmux_conf -> ${tmux_conf}.orig"
  $E mv "$tmux_conf" "${tmux_conf}.orig"
fi
pushd "$HOME" >/dev/null
$E ln -s "$tmux_dot_tmux_conf" ".tmux.conf"
popd >/dev/null

#
# create symlink (~/.tmux)
#
tmux_dir="$HOME/.tmux"
if [ -e "$tmux_dir" ]; then
  echo "move: $tmux_dir -> ${tmux_dir}.orig"
  $E mv "$tmux_dir" "${tmux_dir}.orig"
fi
pushd "$HOME" >/dev/null
$E ln -s "$tmux_dot_tmux_dir" ".tmux"
$E mkdir -p ".tmux/log"
popd >/dev/null
