;; emacs-version predicates
(setq emacs23-p (string-match "^23" emacs-version)
	  emacs24-p (string-match "^24" emacs-version)
	  emacs26-p (string-match "^26" emacs-version))

;(unless (or emacs23-p emacs24-p emacs26-p)
;   __emacs_version_error__)
(unless (or emacs24-p emacs26-p) ;tmux対応のため一旦23を外す
   __emacs_version_error__)

;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
	  linux-p   (eq system-type 'gnu/linux)
	  )
(unless (or darwin-p linux-p)
   __emacs_system_type_error__)

;; load-path
(add-to-list 'load-path "~/.emacs.d/el")

;; initialize
(require 'init-loader)
(setq init-loader-show-log-after-init nil) ;起動時のログバッファを表示しない
(init-loader-load "~/.emacs.d/init")
(if (not (equal (init-loader-error-log) "")) ; エラーがあったときだけログバッファを表示
    (init-loader-show-log))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
