;(when emacs24-p
;  (require 'git-gutter)
;  (global-git-gutter-mode +1)
;  (git-gutter:linum-setup)
;  ;; Use for
;  ;;  'Git'(`git`)
;  ;;  'Mercurial'(`hg`)
;  ;;  'Bazaar'(`bzr`)
;  ;;  'Subversion'(`svn`)
;  (custom-set-variables
;   '(git-gutter:handled-backends '(git hg)))
;  (custom-set-variables
;   '(git-gutter:added-sign "+")
;   '(git-gutter:deleted-sign "-")
;   '(git-gutter:modified-sign "|")))
