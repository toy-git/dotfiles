(defun my-c-mode-hook ()
  (c-set-style "linux")
  (setq tab-width 8)
  (setq c-basic-offset tab-width))
(add-hook 'c-mode-hook 'my-c-mode-hook)