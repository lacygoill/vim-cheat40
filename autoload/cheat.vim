if exists('g:autoloaded_cheat')
    finish
endif
let g:autoloaded_cheat = 1

import Win_getid from 'lg.vim'

" Interface {{{1
fu cheat#open(...) abort "{{{2
    let cmd = a:0 ? a:1 : 'vim'
    let file = g:cheat_dir .. '/' .. cmd
    if !filereadable(file)
        echo '[cheat] ' .. file .. ' is not readable'
        return
    endif
    let index_of_existing_cheat_window =
        \ range(1, winnr('$'))
        \ ->map({_, v -> getwinvar(v, '&ft')})
        \ ->index('cheat')
    if index_of_existing_cheat_window >= 0
        exe index_of_existing_cheat_window .. 'close'
    endif
    " Why 43 instead of 40?{{{
    "
    " Because we set `'signcolumn'` in our vimrc.
    " Because of  this, 3 cells  are consumed by the  sign column (2  on the
    " left, one on the right).
    "
    " If you want to use `40vnew`, reset `'scl'` in the filetype plugin.
    "}}}
    exe 'to 43vnew ' .. file
endfu

fu cheat#completion(_a, _l, _p) abort "{{{2
    sil return systemlist('find ' .. shellescape(g:cheat_dir) .. ' -type f')
        \ ->map({_, v -> fnamemodify(v, ':t:r')})
        \ ->join("\n")
endfu

fu cheat#undo_ftplugin() abort "{{{2
    set bh<
    set bl<
    set cms<
    set cocu<
    set cole<
    set fdl<
    set fdm<
    set fdt<
    set isk<
    set nu<
    set rnu<
    set ro<
    set spell<
    set swf<
    set tags<
    set tw<
    set wfw<
    set wrap<

    nunmap <buffer> q
endfu
"}}}1
" Core {{{1
fu cheat#close_window() abort "{{{2
    if reg_recording() != ''
        return feedkeys('q', 'in')[-1]
    endif
    if s:cheatsheet_is_alone()
        qa!
    else
        let winid = s:Win_getid('#')
        close
        call win_gotoid(winid)
    endif
endfu
"}}}1
" Utilities {{{1
fu s:cheatsheet_is_alone() abort "{{{2
    return tabpagenr('$') == 1
        \ && winnr('$') == 2
        \ && bufname('#') == ''
        \ && getbufline('#', 1, 10) ==# ['']
endfu

