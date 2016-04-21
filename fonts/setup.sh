#!/bin/sh
E=
this_dir="$(cd $(dirname $0); pwd)"
. "$this_dir/../functions"

#
# download
#
font_inconsolata="https://raw.githubusercontent.com/toy-git/fonts/master/ofl/inconsolata/Inconsolata-Regular.ttf"
font_takao="https://launchpadlibrarian.net/199515563/TakaoExFonts_00201.01.tar.xz"

work_dir="$this_dir/work"
mkdir -p "$work_dir" 
pushd  "$work_dir" >/dev/null

$E curl -O "$font_inconsolata"
inconsolata="$work_dir/Inconsolata-Regular.ttf"

#$E curl -O "$font_takao"
$E tar vxJf "$this_dir/TakaoExFonts_00201.01.tar.xz"
$E mv "TakaoExFonts_00201.01/TakaoExGothic.ttf" .
$E rm -rf "$TakaoExFonts_00201.01"
takao="$work_dir/TakaoExGothic.ttf"

popd >/dev/null

#
# install fonts
#
font_dir=
if is_os_mac; then
	font_dir="$HOME/Library/Fonts"
elif is_os_linux; then
	font_dir="$HOME/.fonts"
else
	echo "unknown os type."
	exit 1
fi
mkdir -p "$font_dir"

pushd "$font_dir" >/dev/null
echo "install font: $font_dir"
$E mv "$inconsolata" .
$E mv "$takao" .
$E fc-cache -fv "$font_dir"
popd >/dev/null

rm -rf "$work_dir"
