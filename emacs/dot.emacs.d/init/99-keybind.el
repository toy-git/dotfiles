;; キーバインド一覧を表示
;;  M-x describe-bindings
;;
;; 特定のキーのバインドを知りたいときは、下記を打った後に、知りたいキーをタイプ
;;   M-x describe-key


;;
;; macosx
;;
(when darwin-p
  ;; ¥の入力を/にする
  (define-key global-map [165] [92]) ;; 165が¥（円マーク） , 92が\（バックスラッシュ）を表す
  ;; commandをMeta-Keyにする
  ;(setq ns-command-modifier (quote meta))
  )


;;
;;最近開いたファイルを開く
;;
; C-x C-r: recentf-open-files

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;
;; goto-map
;;
; M-g TAB: move-to-column
; M-g p: previous-error
; M-g n: next-error
; M-g g: goto-line
; M-g c: goto-char

(setq original-goto-map (make-keymap))
(global-set-key (kbd "M-g") original-goto-map)
(define-key original-goto-map (kbd "TAB") 'move-to-column)
(define-key original-goto-map (kbd "p") 'previous-error)
(define-key original-goto-map (kbd "n") 'next-error)
(define-key original-goto-map (kbd "g") 'goto-line)
(define-key original-goto-map (kbd "c") 'goto-char)

;;
;; 対応する括弧に飛ぶ
;;
; C-M-p: backward-list
; C-M-n: forward-list

(global-set-key (kbd "C-M-p") 'backward-list)
(global-set-key (kbd "C-M-n") 'forward-list)

;;
;; 文字コード（改行コード）の切り替え
;;
;;   M-x list-coding-systems で使えるコードが確認可能
;;
; C-x RET r: revert-buffer-with-coding-system <-エンコードを指定して開きなおす
; C-x RET f: set-buffer-file-coding-system    <-バッファのエンコードを変更

(global-set-key (kbd "C-x RET r") 'revert-buffer-with-coding-system)
(global-set-key (kbd "C-x RET f") 'set-buffer-file-coding-system)

;C-hをバックスペースに割り当てる
(global-set-key (kbd "C-h") 'backward-delete-char)

;;
;;M-n, M-pで複数行のカーソル移動
;;
(global-set-key [M-up] 'scroll-up-in-place)
(global-set-key [M-down] 'scroll-down-in-place)

;;
;; X11の fn+delete を
;; "backward delete"ではなく"forward delete"にする
;; ----
;; xevで確認したら、
;;   - delete
;;       keycode 59 (keysym 0xff08, BackSpace)
;;   - fn+delete
;;       keycode 125 (keysym 0xffff, Delete)
;; だった。
(global-set-key [delete] 'delete-char)
(global-set-key [C-delete] 'kill-word)

;;
;; ダイナミックキーボードマクロ(+連番機能)
;;
(require 'ndmacro)
(global-set-key (kbd "C-t") 'ndmacro)

