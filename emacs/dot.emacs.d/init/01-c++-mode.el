;;; C++にて1行80文字を超えるとハイライト
;(add-hook 'c++-mode-hook
;  (lambda ()
;    (font-lock-add-keywords nil
;      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
