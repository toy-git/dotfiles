;;スタートアップ非表示
(setq inhibit-startup-screen t)

;; ツールバー非表示
(if (functionp 'tool-bar-mode)
    (tool-bar-mode -1))

;; スクロールバー非表示
(if (functionp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#800"
                    :height 0.9)

;; 行番号フォーマット
(setq linum-format "%4d")

;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(when emacs24-p
  (set-face-background 'show-paren-match-face "#500"))
(when emacs26-p
  (set-face-attribute 'show-paren-match nil
     :background "#500"))

;; 色の設定
;;  M-x list-colors-display で色見本
;;----
;; TERMが256色有効になってないとだめ。
;; 色が変なときは、
;;   % TERM="xterm-256color" emacs
;; で確認する。
(custom-set-faces
 ;デフォルト色
 '(default ((t
			 (:background "#202020" :foreground "#d7fcfc")
			 )))
 ;コメント色
 '(font-lock-comment-face ((t
			 (:foreground "#ff7777")
			 )))
)

;; 現在行のハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "#2f2f2f"))
   (((class color)
     (background light))
   (:background  "#98FB98"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; 行末の空白を強調表示
;(setq-default show-trailing-whitespace t)
;(set-face-background 'trailing-whitespace "#b14770")

;; タブをスペースで扱う
;(setq-default indent-tabs-mode nil)

;; タブ幅
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(tab-width 4))

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

;; 自動分割するときは、split-window-sensiblyという関数で縦横を自動判別しているが、
;; 常に横分割になるように設定する
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;;
;; フォントの設定
;;
(when window-system
  (create-fontset-from-ascii-font "Inconsolata-12:weight=normal:slant=normal" nil "myfavoritefontset")
  (set-fontset-font "fontset-myfavoritefontset"
					'japanese-jisx0208
					(font-spec :family "TakaoExGothic")
					nil
					'append)
  (add-to-list 'default-frame-alist '(font . "fontset-myfavoritefontset"))
  (setq face-font-rescale-alist
		'(("^-apple-hiragino.*" . 1.2)
		  (".*osaka-bold.*" . 1.2)
		  (".*osaka-medium.*" . 1.2)
		  (".*courier-bold-.*-mac-roman" . 1.0)
		  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
		  (".*monaco-bold-.*-mac-roman" . 0.9)
		  ("-cdac$" . 1.3)
		  (".*Inconsolata.*" . 1.0)))
  )

;; 文字サイズを設定
;; 一時的に調整するなら下記でいい
;;  C-x C-+ 文字の拡大
;;  C-x C-- 文字の縮小
;;  C-x C-0 標準に戻す
;(set-face-attribute 'default nil :height 100)

;;
;; emacs23でも `TERM=screen-256color emacs` を効くようにする
;;
(when (and emacs23-p
		   (string-match "screen-256color" (getenv "TERM"))
		   )
  (defun terminal-init-screen ()
	"Terminal initialization function for screen."
	;; Use the xterm color initialization code.
	(load "term/xterm")
	(xterm-register-default-colors))
  )
