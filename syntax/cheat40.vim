" Author:       Lifepillar
" Maintainer:   Lifepillar
" License:      Distributed under the same terms as Vim itself. See :help license.

if exists("b:current_syntax")
  finish
endif

syntax case ignore
syntax sync fromstart

syn match   Cheat40Command      "\%26v.*\%40v" contains=Cheat40Mode
syn match   Cheat40Header       "^.*{{{\d*$" contains=Cheat40BeginSection
syn region  Cheat40About        start="^About.*{{{2$" end="^}}}$" keepend contains=Cheat40BeginSection,Cheat40EndSection
syn match   Cheat40FirstLine    "\%1l.*"
syn match   Cheat40BeginSection "{{{\d*" conceal contained
syn match   Cheat40EndSection   "^}}}$" conceal
syn match   Cheat40Mode         "[NICVTOM*]\+\%>40v"
syn match   Cheat40Descr      /\%1v.*\%<25v/

hi def link Cheat40Descr   Normal
hi def link Cheat40Command   Constant
hi def link Cheat40Header    Title
hi def link Cheat40About     Comment
hi def link Cheat40FirstLine Statement
hi def link Cheat40BeginSection Ignore
hi def link Cheat40EndSection Ignore
hi def link Cheat40Mode      Label

let b:current_syntax = "cheat40"
