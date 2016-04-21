#!/bin/sh
#
# depends: font
#
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# create ~/.emacs.d
#
emacsd_dir="$HOME/.emacs.d"
pushd "$HOME" >/dev/null
if [ -e "$emacsd_dir" ]; then
    echo "move: $emacsd_dir -> ${emacsd_dir}.orig"
    #$E rm -rf "$emacsd_dir"
    $E mv "$emacsd_dir" "${emacsd_dir}.orig"
fi
$E ln -s "$emacs_dot_emacs_d" ".emacs.d"

#
# delete .emacs
#
emacs="$HOME/.emacs"
if [ -e "$emacs" ]; then
    echo "move: $emacs -> ${emacs}.orig"
    #$E rm -rf "$emacs"
    $E mv "$emacs" "${emacs}.orig"
fi

#
# update submodules
#
elisp_dir="$emacsd_dir/el"
mkdir -p "$elisp_dir"
pushd "$elisp_dir" >/dev/null
# init-loader
curl -O https://raw.githubusercontent.com/toy-git/init-loader/master/init-loader.el
# git-gutter
curl -O https://raw.githubusercontent.com/toy-git/emacs-git-gutter/master/git-gutter.el
# xcscope
curl -O https://raw.githubusercontent.com/toy-git/xcscope/master/cscope-indexer
curl -O https://raw.githubusercontent.com/toy-git/xcscope/master/xcscope.el
# ndmacro
curl -O https://raw.githubusercontent.com/toy-git/ndmacro.el/master/ndmacro.el
# osc52e
curl -O https://gist.githubusercontent.com/toy-git/b8be6193109a964e0dae/raw/d6ef5b677b0026c9cdfea2b1d7b11b79c7dfa540/osc52e.el
popd >/dev/null
