;;; Javaで1行100文字を超えるとハイライト
;(add-hook 'java-mode-hook
;  (lambda ()
;    (font-lock-add-keywords nil
;      '(("^[^\n]\\{100\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
