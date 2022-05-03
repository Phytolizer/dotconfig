function! PackInit() abort
    packadd minpac

    runtime plugins.vim
endfunction

command! PackUpdate source ~/.config/nvim/pack.vim | call PackInit() | call minpac#update()
command! PackClean  source ~/.config/nvim/pack.vim | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

