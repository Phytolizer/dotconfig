function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function find_last(haystack, needle)
	local i = haystack:match(".*" .. needle .. "()")
	if i == nil then
		return nil
	else
		return i - 1
	end
end

function parent_dir(dir)
	last = find_last(dir, "/")
	if last ~= nil then
		return dir:sub(1, last - 1)
	else
		return "/"
	end
end

term_pattern = "/"

function source_local_vimrc()
	cwd = vim.fn.getcwd()
	if not (cwd:find(term_pattern) == 1) then
		return
	end
	while cwd ~= term_pattern do
		path = cwd .. "/.local_vimrc.vim"
		if file_exists(path) then
			vim.cmd("source " .. path)
			-- set working directory to cwd
			vim.cmd("cd " .. cwd)
		end
		cwd = parent_dir(cwd)
	end
end

local id = vim.api.nvim_create_augroup("AutoSource", {})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = source_local_vimrc,
	group = id,
})
