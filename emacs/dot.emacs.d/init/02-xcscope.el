(require 'xcscope)
(setq cscope-do-not-update-database t)
(add-hook 'asm-mode-hook (function cscope:hook))
(set-face-foreground 'cscope-file-face "write")
(set-face-foreground 'cscope-function-face "write")
(set-face-foreground 'cscope-line-number-face "red")
(set-face-foreground 'cscope-line-face "write")
(set-face-foreground 'cscope-mouse-face "write")

;;
;;load cscope-database-regexps setting
;; "~/.emacs.d/init/xcscope/"(system-name)"/*.el"の設定ファイルをロードする
;--------------------------------------------------
;[create cscope database]
;  $ mkdir -p "$idx_dir"
;  $ cd "$idx_dir"
;  $ find "$src_dir" \
;    -path "$src_dir/arch/x86" -prune -o \
;    -regex ".*\.[chxsCHXS\(cpp\)\(cxx\)]$" -print > cscope.files
;  $ cscope -bqk
;--------------------------------------------------
;[emacs setting]
;    (add-to-list 'cscope-database-regexps
;      '("TARGET_SOURCE_PATH_REGEX"
;       ("CSCOPE_INDEX_DIR_PATH1" ("-q" "-k"))
;       ("CSCOPE_INDEX_DIR_PATH2" ("-q" "-k"))
;       ("CSCOPE_INDEX_DIR_PATH3" ("-q" "-k"))
;       ))
;
;  e.g.
;    (add-to-list 'cscope-database-regexps
;      '("^/opt/sources/linux-kernel"
;       ("/opt/sources/inux-kernel_arch-db" ("-q" "-k"))
;       ("/opt/sources/linux-kernel_drivers-db" ("-q" "-k"))
;       ))
;--------------------------------------------------
; (system-name) は *scratch* で C-j で確認する
(if (file-directory-p (concat "~/.emacs.d/init/xcscope/" (system-name)))
    (load-system-depended-config (concat "~/.emacs.d/init/xcscope/" (system-name))))

