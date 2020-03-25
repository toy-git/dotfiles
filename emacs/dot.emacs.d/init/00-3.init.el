;;
;; マシン依存の設定を読込み
;;
(if (file-directory-p (concat "~/.emacs.d/init/init/" (system-name)))
    (load-system-depended-config (concat "~/.emacs.d/init/init/" (system-name))))

;;
;; emacs server
;;
(require 'server)
(setq server-socket-dir "~/.emacs.d/server")
;(unless (server-running-p)
;  (server-start))   <= サーバ名をユニークにするため。起動時の引き数で --eval してstart-serverする。.zshrc参照。

;; 矩形選択
;;   C-x SPC で矩形選択
;;   M-p 矩形の幅を固定
;;   M-b 空白文字で埋める。 open-rectangle と同等
;;   M-s 文字列で置き換える。 string-rectangle と同等
;;   M-f 1種類の文字で埋める。 string-rectangle で1文字指定したときと同等
;;   M-i 矩形領域内の数字をインクリメントする
;;   M-n 矩形領域を連番で埋める。フォーマット指定可
;;
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;;
;; バッファ自動再読み込み
;;
(global-auto-revert-mode 1)

;;
;; バックアップファイルの置き場所を指定する
;;
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/bak"))
            backup-directory-alist))

;;
;; C-x C-f /path/to/file:20 で指定行を開く
;;
;; http://stackoverflow.com/questions/3139970/open-a-file-at-line-with-filenameline-syntax/3141456#3141456
(defadvice find-file (around find-file-line-number
                             (filename &optional wildcards)
                             activate)
  "Turn files like file.cpp:14 into file.cpp and going to the 14-th line."
  (save-match-data
    (let* ((matched (string-match "^\\(.*\\):[+]*\\([0-9]+\\):?$" filename))
           (line-number (and matched
                             (match-string 2 filename)
                             (string-to-number (match-string 2 filename))))
           (filename (if matched (match-string 1 filename) filename)))
      ad-do-it
      (when line-number
        ;; goto-line is for interactive use
        (goto-char (point-min))
        (forward-line (1- line-number))))))

;;
;; 保存時に行末の空白、TABを削除
;;
;; 除外したい拡張子
(setq delete-trailing-whitespace-exclude-patterns
;;	  (list "\\.md$")
	  (list "\\.c$" "\\.h$" "\\.md$" "\\.patch$")
)

(require 'cl)
(defun delete-trailing-whitespace-with-exclude-pattern ()
  (interactive)
  (cond ((equal nil (loop for pattern in delete-trailing-whitespace-exclude-patterns
                          thereis (string-match pattern buffer-file-name)))
         (delete-trailing-whitespace))))
(add-hook 'before-save-hook 'delete-trailing-whitespace-with-exclude-pattern)
