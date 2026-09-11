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
				-- on_attach = function(bufnr)
				-- 	-- Jump forwards/backwards with '{' and '}'
				-- 	vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				-- 	vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				-- end,
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
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			-- Install plugins
			local ensureInstalled = {
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
				"python",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)
		end,
	},
}
