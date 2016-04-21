#!/bin/sh
E=echo
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create symlink
#
gitconfig="$home_dir/.gitconfig"
pushd "$HOME" >/dev/null
if [ -e "$gitconfig" ]; then
  echo "move: $gitconfig -> ${gitconfig}.orig"
  $E mv "$gitconfig" "${gitconfig}.orig"
fi
$E ln -s "$git_dot_gitconfig" ".gitconfig"
popd >/dev/null

