vim.api.nvim_set_keymap('i', '<C-CR>', 'copilot#Accept("<CR>")', {
    noremap = true,
    expr = true,
    silent = true,
})
vim.g.copilot_no_tab_map = true

