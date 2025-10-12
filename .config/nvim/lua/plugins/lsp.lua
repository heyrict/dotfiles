return {
	-- Conform
	{
		"stevearc/conform.nvim", -- Formatter plugin
		branch = "master",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				rust = { "rustfmt", lsp_format = "fallback" },
				markdown = {},
				d2 = { "d2" },
				sql = { "sqruff" },
				["_"] = { "trim_whitespace" },
			},
			-- Set this to change the default values when calling conform.format()
			-- This will also affect the default values for format_on_save/format_after_save
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
			-- Conform will notify you when no formatters are available for the buffer
			notify_no_formatters = true,
			formatters = {
				d2 = {
					command = "d2",
					args = { "fmt", "$FILENAME" },
					stdin = false,
				},
			},
		},
	},
	-- LSP, snippets and complete
	{
		"neovim/nvim-lspconfig",
		branch = "master",
		dependencies = {
			"hrsh7th/nvim-cmp",
			-- LSP
			"hrsh7th/cmp-nvim-lsp",
			-- Snippets
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			-- Vimtex
			"micangl/cmp-vimtex",
			"lervag/vimtex",
		},
		init = function()
			-- Vimtex
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_doc_handlers = { "vimtex#doc#handlers#texdoc" }
			vim.g.vimtex_syntax_enabled = 0

			vim.diagnostic.enable = true
			vim.diagnostic.config({
				virtual_lines = true,
			})
		end,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			-- nvim-cmp setup
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
					-- C-b (back) C-f (forward) for snippet placeholder navigation.
					["<C-y>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "vimtex" },
				},
			})

			-- LSP: lua_ls
			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
					end
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
				capabilities = capabilities,
			})

			-- LSP: rust_analyzer
			vim.lsp.enable("rust_analyzer")
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
					},
				},
			})

			-- LSP: python
			vim.lsp.enable("ruff")
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
						},
					},
				},
			})
			vim.lsp.enable("basedpyright")

			-- LSP: typescript
			vim.lsp.enable("ts_ls")
			vim.lsp.config("ts_ls", {
				settings = {
					typescript = {
						format = {
							indentSize = 2,
						},
					},
				},
			})

			-- LSP: SQL
			vim.lsp.enable("sqruff")

			-- LSP: spellcheck
			vim.lsp.enable("harper_ls")
			vim.lsp.config("harper_ls", {
				settings = {
					["harper-ls"] = {
						fileDictPath = "~/.cache/harper/",
						userDictPath = "~/.local/share/harper/dict.txt",
						isolateEnglish = true,
						markdown = {
							ignore_link_title = true,
							ignoreLinkTitle = true,
						},
					},
				},
			})

			-- LSP: Keys
			vim.keymap.set({ "n" }, "<space>rn", ":lua vim.lsp.buf.rename()<cr>")
		end,
	},
	-- FZF
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/which-key.nvim",
		},
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
		config = function()
			local fzf = require("fzf-lua")
			local wk = require("which-key")

			-- LSP: keys
			-- Key mappings
			local opts = { buffer = true }

			wk.add({
				{ "<space>f", group = "Fzf" },
				{
					mode = "n",
					{
						"<space>fi",
						function()
							fzf.files()
						end,
						desc = "Files",
					},
					{
						"<space>fd",
						function()
							fzf.diagnostics_document()
						end,
						desc = "Document Diagnostics",
					},
					{
						"<space>fw",
						function()
							fzf.diagnostics_workspace()
						end,
						desc = "Workspace Diagnostics",
					},
					{
						"<space>fl",
						function()
							fzf.loclist()
						end,
						desc = "Loclist",
					},
					{
						"<space>ff",
						function()
							fzf.quickfix()
						end,
						desc = "Quickfix",
					},
				},
			})

			wk.add({
				{ "<space>l", group = "Lsp" },
				{
					mode = { "n" },
					{
						"<space>lc",
						function()
							fzf.lsp_code_actions()
						end,
						desc = "Code Actions",
					},
					{
						"<space>ld",
						function()
							fzf.lsp_definitions()
						end,
						desc = "Definitions",
					},
					{
						"<space>ll",
						function()
							fzf.lsp_declarations()
						end,
						desc = "Declarations",
					},
					{
						"<space>lr",
						function()
							fzf.lsp_references()
						end,
						desc = "References",
					},
					{
						"<space>li",
						function()
							fzf.lsp_implementations()
						end,
						desc = "Implementations",
					},
					{
						"<space>ly",
						function()
							fzf.lsp_typedefs()
						end,
						desc = "Typedefs",
					},
					{
						"<space>ln",
						function()
							vim.lsp.buf.rename()
						end,
						desc = "Rename variable",
					},
				},
			})
		end,
	},
	-- Pandoc
	{
		"jc-doyle/cmp-pandoc-references",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup.filetype("markdown", {
				sources = {
					{ name = "luasnip" },
					{ name = "pandoc_references" },
				},
			})
		end,
	},
}
