require("todo-comments").setup({
	highlight = {
		before = "",
		keyword = "bg",
		after = "fg",
		pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
		comments_only = true,
		max_line_len = 400,
		exclude = {},
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
	},
})
