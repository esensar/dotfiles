" Vim Compiler File
" Compiler: gradlew

if exists("current_compiler")
    finish
endif
let current_compiler = "gradlew"

let s:save_cpo = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=./gradlew

CompilerSet errorformat=
    \%E[ant:scalac]\ %f:%l:\ error:\ %m,
    \%W[ant:scalac]\ %f:%l:\ warning:\ %m,
    \%E%.%#:compile%\\w%#Java%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,
    \%W%.%#:compile%\\w%#Java%f:%l:\ warning:\ %m,%-Z%p^,%-C%.%#,
    \%E%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,
    \%W%f:%l:\ warning:\ %m,%-Z%p^,%-C%.%#,
    \%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%-G%.%#

let &cpo = s:save_cpo
unlet s:save_cpo
