#!/bin/sh
E=echo
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create symlink
#
hgrc="$HOME/.hgrc"
pushd "$HOME" >/dev/null
if [ -e "$hgrc" ]; then
  echo "move: $hgrc -> ${hgrc}.orig"
  $E mv "$hgrc" "${hgrc}.orig"
fi
$E ln -s "$hg_dot_hgrc" ".hgrc"
popd >/dev/null
