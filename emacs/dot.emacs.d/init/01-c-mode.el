(defun my-c-mode-hook ()
  (c-set-style "linux")
  (setq tab-width 4)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil)) ;インデントをタブではなくスペースにする
(add-hook 'c-mode-hook 'my-c-mode-hook)

;;; Cにて1行80文字を超えるとハイライト
;(add-hook 'c-mode-hook
;  (lambda ()
;    (font-lock-add-keywords nil
;      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
