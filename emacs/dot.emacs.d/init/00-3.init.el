;;
;; マシン依存の設定を読込み
;;
(if (file-directory-p (concat "~/.emacs.d/init/init/" (system-name)))
    (load-system-depended-config (concat "~/.emacs.d/init/init/" (system-name))))

;;
;; emacs server
;;
(require 'server)
(unless (server-running-p)
  (server-start))

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
;; ダイナミックキーボードマクロ(+連番機能)
;;
(require 'ndmacro)
(global-set-key (kbd "C-t") 'ndmacro)

