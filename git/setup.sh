#!/bin/sh
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create symlink
#
gitconfig="$HOME/.gitconfig"
pushd "$HOME" >/dev/null
if [ -e "$gitconfig" ]; then
  echo "move: $gitconfig -> ${gitconfig}.orig"
  $E mv "$gitconfig" "${gitconfig}.orig"
fi
$E ln -s "$git_dot_gitconfig" ".gitconfig"

ln -s "$this_dir" .git.d
popd >/dev/null

#
# download Count Lines of Code.
#
git_tools_dir="$this_dir/git-tools"
mkdir -p "$git_tools_dir"
pushd "$git_tools_dir" >/dev/null
git clone https://github.com/toy-git/cloc.git cloc
popd >/dev/null
