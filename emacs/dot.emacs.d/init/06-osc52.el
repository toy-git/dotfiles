(when darwin-p ;[macosx] http://hakurei-shain.blogspot.jp/2010/05/mac.html
  (defun copy-from-osx ()
	(shell-command-to-string "pbpaste"))
  
  (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
		(process-send-string proc text)
		(process-send-eof proc))))
  
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  )

(when linux-p ;[linux] https://gist.github.com/AlexCharlton/cc82001c407786f7c1f7
  (require 'osc52e)
  (osc52-set-cut-function)
  )
