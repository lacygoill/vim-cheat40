" Options {{{1
" window options {{{2

" TODO: Set them from an autocmd listening to `BufWinEnter`?{{{
"
" ---
"
" `wfw` is not a buffer option.  Move it here?
"
" ---
"
" Review `~/wiki/vim/todo.md`.
" Did we write that window-local options should be set from an autocmd listening
" to `BufWinEnter`? If not, should we?
"}}}
setl fdl=1 fdm=marker fdt=getline(v:foldstart)->substitute('\\s\\+{{\\%x7b.*$','','')
setl cocu=nc cole=3
setl nonu nornu
setl nospell
setl nowrap

" buffer options {{{2

" TODO: Should we set `bh` to `delete`?{{{
"
" If we do it, we lose the ability to retrieve the buffer when pressing `C-^` twice.
" Unless we populate the buffer via an autocmd listening to `BufNewFile`.
" If we don't, then review `~/wiki/vim/todo.md`.
"
" ---
"
" If you use `delete`, you lose the auto-open-fold feature after pressing `C-^` twice.
" In that case, you should probably set the feature from this filetype plugin.
"}}}
" TODO: Does `bh` have an influence on how window-local options are applied when{{{
" a  cheat  buffer is  displayed  in  a  window,  while it's  already  displayed
" somewhere else, or when we press `C-^` twice?
"
" ---
"
" It doesn't seem to cause an issue:
"
"     $ cs tmux
"     :setl list
"     C-l
"     C-^
"
" `'list'` is set in the second window, even when we use `bh=delete`.
"}}}
" TODO: What  about moving  the comments  of a  cheatsheet inside  popup windows
" opened dynamically when hovering the relevant line?
setl bh=hide nobl noswf ro wfw

setl cms=#\ %s
setl tw=40
setl isk=@,48-57,-,/,.,192-255
exe 'setl tags=' .. g:cheat_dir .. '/tags'

call toggleSettings#autoOpenFold(v:true)
" TODO: if you keep the autocmd, clear it in b:undo_ftplugin
augroup CheatOpenFold
    au! * <buffer>
    " `zM` is important!{{{
    "
    " Without,  when you  press `j`  or `k`,  the folds  won't be  automatically
    " opened/closed; at least not until you've pressed `zM`.
    " For an explanation, see:
    "
    "     ~/.vim/plugged/vim-toggle-settings/autoload/toggleSettings.vim
    "     /MoveAndOpenFold
    "     ?Warning
    "}}}
    au BufWinEnter <buffer> norm! zMzv
augroup END
"}}}1
" Mappings {{{1

nno <buffer><nowait> q <cmd>call cheat#closeWindow()<cr>

" Teardown {{{1

let b:undo_ftplugin = get(b:, 'undo_ftplugin', 'exe')
    \ .. '| call cheat#undoFtplugin()'

