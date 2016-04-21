;;
;; 指定ディレクトリの.elを全てロードする
;;
(defun load-system-depended-config (directory)
  "Load the .el files in DIRECTORY and in its sub-directories."
  (interactive "DDirectory name: ")

  (let (loaded-sysdep-el-files-list
        (current-directory-sysdep-el-list
         (directory-files-and-attributes directory t)))
    ;; while we are in the current directory
    (while current-directory-sysdep-el-list

      (cond
       ;; check to see whether filename ends in `.el'
       ;; and if so, append its name to a list.
       ((equal ".el" (substring (car (car current-directory-sysdep-el-list)) -3))
        (load-file (car (car current-directory-sysdep-el-list)))
        (setq loaded-sysdep-el-files-list
              (cons (car (car current-directory-sysdep-el-list)) loaded-sysdep-el-files-list)))

       ;; check whether filename is that of a directory
       ((eq t (car (cdr (car current-directory-sysdep-el-list))))
        ;; decide whether to skip or recurse
        (if
            (equal "."
                   (substring (car (car current-directory-sysdep-el-list)) -1))
            ;; then do nothing since filename is that of
            ;;   current directory or parent, "." or ".."
            ()

          ;; else descend into the directory and repeat the process
          (setq loaded-sysdep-el-files-list
                (append
                 (load-system-depended-config
                  (car (car current-directory-sysdep-el-list)))
                 loaded-sysdep-el-files-list)))))
      ;; move to the next filename in the list; this also
      ;; shortens the list so the while loop eventually comes to an end
      (setq current-directory-sysdep-el-list (cdr current-directory-sysdep-el-list)))
    ;; return the filenames
    loaded-sysdep-el-files-list))

;;
;; 3行ずつスクロールしながらカーソル移動
;;
(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line 3)
  (scroll-down 3))
(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line 3)
  (scroll-up 3))
