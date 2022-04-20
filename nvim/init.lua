vim.opt.background = 'dark'
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- vim.opt.autochdir = true
vim.opt.cinoptions = {
    'l1',
    'g0.5s',
    'h0.5s',
    'E-s',
    't0',
    'i2s',
    '+2s',
    'c1s',
    'm1',
}
vim.opt.clipboard = 'unnamedplus'

if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
end

vim.g.mapleader = ' '

vim.api.nvim_set_keymap(
    'n',
    '<esc>',
    '<cmd>nohlsearch<CR>',
    { noremap = true, silent = true }
)

require('my_modules.plugins')
require('my_modules.plugins.airline')
require('my_modules.plugins.copilot')
if vim.g.neovide then
    require('my_modules.neovide')
end
require('my_modules.autosource')

