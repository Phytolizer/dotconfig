require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "cpp", "haskell", "python", "rust", "vim" },
	sync_install = false,
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = true,
	},
})
