set termguicolors
set nohlsearch
set autowrite
set nowrap
set number
set numberwidth=4
set signcolumn=yes
set shiftround
set wildignore=*.o
set directory=~/.config/nvim/swap//
set clipboard^=unnamedplus
set diffopt+=internal,algorithm:patience
set completeopt=menu,menuone,noselect
set virtualedit=all
set list
set listchars=tab:\|\ ,trail:-
imap <C-c> <Esc>

runtime autosource.vim

autocmd BufRead,BufNewFile .clang-format set ft=yaml
autocmd BufRead,BufNewFile .clang-tidy set ft=yaml
autocmd BufRead,BufNewFile .clangd set ft=yaml

function! PackInit() abort
    packadd minpac

    runtime plugins.vim
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

let g:airline_theme = 'base16_ocean'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols_ascii = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let base16colorspace=256
colorscheme base16-ocean
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:formatters_c = ['clang_format']
let g:formatdef_clang_format = '"clang-format"'
let g:formatters_rs = ['rustfmt']
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_haskell = ['hindent']
let g:formatdef_hindent = '"hindent"'
let g:formatters_python = ['black', 'isort']
let g:formatdef_black = '"black"'
let g:formatdef_isort = '"isort -"'
let g:formatters_sh = ['shfmt']
let g:formatdef_shfmt = '"shfmt -"'
let g:formatters_lua = ['stylua']
let g:formatdef_stylua = '"stylua -"'
let g:formatters_json = ['prettier']
let g:formatters_yaml = ['prettier']
let g:formatdef_prettier = '"prettier"'
let g:rooter_patterns = ['.git', '.local_vimrc.vim']
autocmd FileType vim let b:autoformat_autoindent = 1
autocmd FileType json syntax sync minlines=100
autocmd BufWrite * :Autoformat
let g:AutoPairs = {'(': ')', '[': ']', '{': '}'}
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
nnoremap <space>S <cmd>lua require('spectre').open()<CR>
vnoremap <space>s <cmd>lua require('spectre').open_visual()<CR>
let g:tex_flavor='latex'

lua require('user.lsp')
lua require('user.treesitter')
lua require('user.cmp')
lua require('user.todo')
lua require('user.devicons')
lua require('user.sad')
