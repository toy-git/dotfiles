#!/bin/sh
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create symlink
#
zshrc="$HOME/.zshrc"
pushd "$HOME" >/dev/null
if [ -e "$zshrc" ]; then
	echo "move: $zshrc -> ${zshrc}.orig"
	$E mv "$zshrc" "${zshrc}.orig"
fi
$E ln -s "$zsh_dot_zshrc" ".zshrc"
