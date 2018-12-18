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

;;
;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
;;
(cua-mode t)
(setq cua-enable-cua-keys nil)

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
    (let* ((matched (string-match "^\\(.*\\):\\([0-9]+\\):?$" filename))
           (line-number (and matched
                             (match-string 2 filename)
                             (string-to-number (match-string 2 filename))))
           (filename (if matched (match-string 1 filename) filename)))
      ad-do-it
      (when line-number
        ;; goto-line is for interactive use
        (goto-char (point-min))
        (forward-line (1- line-number))))))
