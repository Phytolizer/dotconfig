function! s:current()
    let fname = expand('%:p', 1)
    if empty(fname)
        return getcwd()
    endif
    return fnamemodify(fname, ':h')
endfunction

function! s:parent(dir)
    return fnamemodify(a:dir, ':h')
endfunction

function! AutoSource()
    let dir = s:current()
    while 1
        let path = dir . '/.local_vimrc.vim'
        if filereadable(path)
            exec 'source '.fnameescape(path)
            break
        endif
        let [current, dir] = [dir, s:parent(dir)]
        if current == dir
            break
        endif
    endwhile
endfunction

augroup autosource
    autocmd!
    autocmd VimEnter,BufReadPost,BufEnter * call AutoSource()
augroup END

