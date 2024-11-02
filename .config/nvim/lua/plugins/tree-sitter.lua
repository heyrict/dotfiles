return {
	-- Aerial
	{
		"stevearc/aerial.nvim",
		keys = { { "<F8>", mode = "n" } },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				keymaps = {
					["?"] = "actions.show_help",
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.jump",
					["<2-LeftMouse>"] = "actions.jump",
					["<C-v>"] = "actions.jump_vsplit",
					["<C-s>"] = "actions.jump_split",
					["p"] = "actions.scroll",
					["<C-j>"] = "actions.down_and_scroll",
					["<C-k>"] = "actions.up_and_scroll",
					["{"] = "actions.prev",
					["}"] = "actions.next",
					["[["] = "actions.prev_up",
					["]]"] = "actions.next_up",
					["q"] = "actions.close",
					["o"] = "actions.tree_toggle",
					["za"] = "actions.tree_toggle",
					["O"] = "actions.tree_toggle_recursive",
					["zA"] = "actions.tree_toggle_recursive",
					["l"] = "actions.tree_open",
					["zo"] = "actions.tree_open",
					["L"] = "actions.tree_open_recursive",
					["zO"] = "actions.tree_open_recursive",
					["h"] = "actions.tree_close",
					["zc"] = "actions.tree_close",
					--["H"] = "actions.tree_close_recursive",
					["zC"] = "actions.tree_close_recursive",
					["zr"] = "actions.tree_increase_fold_level",
					["zR"] = "actions.tree_open_all",
					["zm"] = "actions.tree_decrease_fold_level",
					["zM"] = "actions.tree_close_all",
					["zx"] = "actions.tree_sync_folds",
					["zX"] = "actions.tree_sync_folds",
				},
			})
			vim.keymap.set("n", "<F8>", "<cmd>AerialToggle<CR>")
		end,
	},
	-- Tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"css",
					"html",
					"javascript",
					"just",
					"latex",
					"lua",
					"markdown",
					"rust",
					"typescript",
					"vim",
					"vimdoc",
					"json",
					"toml",
					"yaml",
				},
				sync_install = false,
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			})

			vim.opt.foldminlines = 1
			vim.opt.foldnestmax = 8
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},
}
