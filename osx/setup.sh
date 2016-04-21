#!/bin/sh
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# modify keymap
#
xmodmap="$HOME/.Xmodmap"
pushd "$HOME" >/dev/null
if [ -e "$xmodmap" ]; then
    echo "move: $xmodmap -> ${xmodmap}.orig"
    #$E rm -rf "$xmodmap"
    $E mv "$xmodmap" "${xmodmap}.orig"
fi
$E ln -s "$osx_xmodemap" ".xmodmap"
popd >/dev/null

