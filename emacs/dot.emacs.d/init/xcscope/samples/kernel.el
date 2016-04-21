(add-to-list 'cscope-database-regexps
  '("^/opt/sources/linux-2.6"
   ("/opt/sources/cscope-database/linux2_db" ("-q" "-k"))
   ("/opt/sources/cscope-database/linux2_arch_db" ("-q" "-k"))
   ))

(add-to-list 'cscope-database-regexps
  '("^/opt/sources/linux-3.0"
   ("/opt/sources/cscope-database/linux3_db" ("-q" "-k"))
   ("/opt/sources/cscope-database/linux3_arch_db" ("-q" "-k"))
   ))
