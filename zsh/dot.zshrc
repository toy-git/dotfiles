this="${BASH_SOURCE:-${(%):-%N}}"
while [ -h "$this" ]
do
	this=`readlink "$this"`
done
this_dir="$(cd "$(dirname "$this")"; pwd)"

############################################
# GENERAL
export EDITOR=emacs       # エディタをemacsに設定
export LANG=en_US.UTF-8   # 文字コードをUTF-8に設定
export LC_ALL=en_US.UTF-8 # 文字コードをUTF-8に設定
export KCODE=u            # KCODEにUTF-8を設定
export AUTOFEATURE=true   # autotestでfeatureを動かす

bindkey -e               # キーバインドをemacsモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### word-chars ###
autoload -Uz select-word-style         #単語の区切り文字を変更
select-word-style default              # word-charsで指定可能
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z" or "^[[Z")
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=1 #補完候補をカーソルで選択する

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

############################################
# LOOK AND FEEL
export LSCOLORS=Exfxcxdxbxegedabagacad

export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

export ZLS_COLORS=$LS_COLORS

export CLICOLOR=true

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -U colors; colors
if [ -n "$SSH_CONNECTION" ]; then
    tmp_prompt='%n@%m'
fi

# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}${tmp_prompt} %# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt=""
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi
PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

############################################
# COMMAND

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -a -l'

# tmux環境をローカルに入れた場合の設定
alias tmux='t'
function t () {
	local ld_library_path="${HOME}/usr/local/lib"
	if [ -d "$ld_library_path" ]; then
	   ld_library_path=''
	fi
	ld_library_path="$ld_library_path:$LD_LIBRARY_PATH"

	local tmux="${HOME}/usr/local/bin/tmux"
	if [ ! -x "${HOME}/usr/local/bin/tmux" ]; then
	   tmux='tmux'
	fi

	if [ $# -eq 0 ]; then
		LD_LIBRARY_PATH="$ld_library_path"		\
		"$tmux" new-session \;	\
		pipe-pane -o '/bin/sh -c "\"${HOME}/.tmux/util/logger/mark.sh\" \"#S\" \"#I\" \"#P\"; while read -r L; do \"${HOME}/.tmux/util/logger/write.sh\" \"\${L}\" \"#S\" \"#I\" \"#P\"; done "'
	else
		LD_LIBRARY_PATH="$ld_library_path" "$tmux" "$@" \;	\
		pipe-pane -o '/bin/sh -c "\"${HOME}/.tmux/util/logger/mark.sh\" \"#S\" \"#I\" \"#P\"; while read -r L; do \"${HOME}/.tmux/util/logger/write.sh\" \"\${L}\" \"#S\" \"#I\" \"#P\"; done "'
	fi
}

# 起動済みのemacsを使ってファイルを開く
# emacsが起動していない場合は、emacsを起動する(-aオプション)
# emacs設定に下記の記載が必要
# ----
# (require 'server)
# (unless (server-running-p)
#   (server-start))
# ----
function e () {
	local emacs=`which emacs`
	if [ $# -ne 0 ]; then
		emacsclient -a "$emacs" --no-wait $@ &
	fi
}