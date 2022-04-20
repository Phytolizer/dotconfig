return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tpope/vim-surround")
	use("editorconfig/editorconfig-vim")
	use({
		"norcalli/nvim-base16.lua",
		config = function()
			local base16 = require("base16")
			base16(base16.themes[vim.env.BASE16_THEME or "black-metal"], true)
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			local lsp = require("lspconfig")
			local opts = {
				noremap = true,
				silent = true,
			}
			vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
			vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wa",
					"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wr",
					"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					opts
				)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
			end

			local caps = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

			lsp.clangd.setup({
				cmd = {
					"clangd",
					"--header-insertion=never",
				},
				on_attach = function(client, bufnr)
					client.resolved_capabilities.document_formatting = flase
					client.resolved_capabilities.document_range_formatting = false
					on_attach(client, bufnr)
				end,
				capabilities = caps,
			})

			lsp.pyright.setup({
				on_attach = on_attach,
				capabilities = caps,
			})

			lsp.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = caps,
			})
		end,
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-g>"] = cmp.mapping.abort(),
					["<TAB>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				enabled = function()
					-- disable in comment context
					local context = require("cmp.config.context")
					if vim.api.nvim_get_mode() == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"rust",
					"glsl",
				},
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
			})
		end,
		run = ":TSUpdate",
	})
	use("github/copilot.vim")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"ellisonleao/glow.nvim",
		branch = "main",
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local n = require("null-ls")
			n.setup({
				sources = {
					n.builtins.formatting.stylua,
					n.builtins.formatting.clang_format.with({
						extra_filetypes = { "glsl" },
					}),
				},
				on_attach = function(client)
					if client.resolved_capabilities.document_formatting then
						local id = vim.api.nvim_create_augroup("LspFormatting", {})
						vim.api.nvim_create_autocmd({ "BufWritePre" }, {
							pattern = { "<buffer>" },
							group = id,
							command = "lua vim.lsp.buf.formatting_sync()",
						})
					end
				end,
			})
		end,
	})
	use({
		"andweeb/presence.nvim",
		config = function()
			require("presence"):setup({
				main_image = "file",
			})
		end,
	})
end)
