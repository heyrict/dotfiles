return {
	{
		"robitx/gp.nvim",
		config = function()
			local zhipu_key = { "secret-tool", "lookup", "url", "https://open.bigmodel.cn/api/paas/v4/" }
			local volceengine_key = { "secret-tool", "lookup", "model_provider", "volceengine" }
			local conf = {
				providers = {
					zhipu = {
						endpoint = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
						secret = zhipu_key,
					},
					zhipu_coding = {
						endpoint = "https://open.bigmodel.cn/api/coding/paas/v4/chat/completions",
						secret = zhipu_key,
					},
					volceengine = {
						endpoint = "https://ark.cn-beijing.volces.com/api/v3/chat/completions#",
						secret = volceengine_key,
					},
				},
				agents = {
					{
						name = "CodeGPT4o",
						disable = true,
					},
					{
						name = "CodeGPT4o-mini",
						disable = true,
					},
					{
						provider = "zhipu_coding",
						name = "glm-4.5",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4.5", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "zhipu_coding",
						name = "glm-4.5-air",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4.5-air", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "zhipu",
						name = "glm-4.5-flash",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4.5-flash", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "zhipu",
						name = "codegeex-4",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "codegeex-4", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").code_system_prompt,
					},
					{
						provider = "volceengine",
						name = "deepseek-r1-distill-qwen-7b",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = "ep-20250218183103-nzpmb",
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "volceengine",
						name = "deepseek-r1",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = "ep-20250218183001-njqb4",
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
				},
				default_command_agent = "glm-4.5-flash",
				default_chat_agent = "glm-4.5-flash",
				chat_template = require("gp.defaults").short_chat_template,
				whisper = { disabled = true },
				image = {
					agents = {
						{
							provider = "zhipu",
							name = "cogview-3-plus",
							model = "cogview-3-plus",
							size = "1440x720",
							quality = "standard",
							style = "natural",
						},
					},
				},
				hooks = {
					ProofRead = function(gp, params)
						local template = "你作为学术领域的引领者，在各个领域拥有丰富的学术经验与专业知识，不仅参与前沿研究，还积极分享经验与见解擅长学术写作规范，提升论文的品质与影响力，精细润色每个细节，优化语言表达与逻辑结构。以下是你需要修改的内容:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "请在细阅全文并确保理解论文核心观点的基础上，细致调整表述，使语言更为专业、连贯，逻辑清晰，必要时采用更为精准和学术化的词汇替换原有语句，同时确保不改变原意，以增强论文的专业性和学术性。请直接给出修改后的全文，不要给出其它任何提示词。"
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.vnew, agent, template)
					end,
					Translate = function(gp, params)
						local template = "你是一名专业的翻译助手，你的工作是进行中英互译。以下是文件 {{filename}} 中的一段话:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "你在翻译过程中需要采用精准且符合本土化语境的词汇。请确保你的翻译既保留了原文的意图，又能够适应目标语言的文化和习惯。在翻译过程中，对于专业术语、成语或文化特定的表达，务必寻找最恰当的对应词汇，同时在保持原文风格的基础上，尽量做到语言地道、通顺。我希望您将我的简化至 A0 级的词汇和句子替换为更优美、更高级的词汇和句子。保持原意不变，但要使其更严谨且具科学性。我只希望您提供修改和改进，无需其他内容。请翻译以上文章。"
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.vnew, agent, template)
					end,
				},

				-- (be careful to choose something which will work across specified modes)
				chat_shortcut_respond = { modes = { "n", "v" }, shortcut = "gpo" },
				chat_shortcut_delete = { modes = { "n", "v" }, shortcut = "gpd" },
				chat_shortcut_stop = { modes = { "n", "v" }, shortcut = "gps" },
				chat_shortcut_new = { modes = { "n", "v" }, shortcut = "gpn" },
				-- default search term when using :GpChatFinder
				chat_finder_pattern = "topic ",
				chat_finder_mappings = {
					delete = { modes = { "n", "v" }, shortcut = "dd" },
				},
			}
			require("gp").setup(conf)

			-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
			local function keymapOptions(desc)
				return {
					noremap = true,
					silent = true,
					nowait = true,
					desc = "GPT prompt " .. desc,
				}
			end

			vim.keymap.set({ "n" }, "gpc", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
			vim.keymap.set({ "n" }, "gpt", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
			vim.keymap.set({ "n" }, "gpf", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

			vim.keymap.set("v", "gpc", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
			vim.keymap.set("v", "gpp", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
			vim.keymap.set("v", "gpt", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

			vim.keymap.set({ "n" }, "gp-", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
			vim.keymap.set({ "n" }, "gp|", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
			vim.keymap.set({ "n" }, "gpT", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

			vim.keymap.set("v", "gp-", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
			vim.keymap.set("v", "gp|", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
			vim.keymap.set("v", "gpT", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

			-- Prompt commands
			vim.keymap.set({ "n" }, "gpr", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
			vim.keymap.set({ "n" }, "gpA", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
			vim.keymap.set({ "n" }, "gpI", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

			vim.keymap.set("v", "gpr", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
			vim.keymap.set("v", "gpA", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
			vim.keymap.set("v", "gpI", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
			vim.keymap.set("v", "gpi", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

			vim.keymap.set({ "n" }, "gpgp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
			vim.keymap.set({ "n" }, "gpge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
			vim.keymap.set({ "n" }, "gpg-", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
			vim.keymap.set({ "n" }, "gpg|", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
			vim.keymap.set({ "n" }, "gpgT", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

			vim.keymap.set("v", "gpgp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
			vim.keymap.set("v", "gpge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
			vim.keymap.set("v", "gpg-", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
			vim.keymap.set("v", "gpg|", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
			vim.keymap.set("v", "gpgT", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

			vim.keymap.set("v", "gpgr", ":<C-u>'<,'>GpProofRead<cr>", keymapOptions("GpProofRead"))
			vim.keymap.set("v", "gpgt", ":<C-u>'<,'>GpTranslate<cr>", keymapOptions("GpTranslate"))

			vim.keymap.set({ "n" }, "gpx", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
			vim.keymap.set("v", "gpx", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

			vim.keymap.set({ "n", "v" }, "gps", "<cmd>GpStop<cr>", keymapOptions("Stop"))
			vim.keymap.set({ "n", "v" }, "gpa", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			-- add any opts here
			-- for example
			provider = "zhipu",
			providers = {
				zhipu_coding = {
					__inherited_from = "openai",
					endpoint = "https://open.bigmodel.cn/api/coding/paas/v4",
					api_key_name = "cmd:secret-tool lookup url https://open.bigmodel.cn/api/paas/v4/",
					model_names = { "glm-4.5", "glm-4.5-air", "glm-4.6" }, -- your desired model (or use gpt-4o, etc.)
					-- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
				},
				zhipu = {
					__inherited_from = "openai",
					endpoint = "https://open.bigmodel.cn/api/paas/v4",
					api_key_name = "cmd:secret-tool lookup url https://open.bigmodel.cn/api/paas/v4/",
					model_names = { "glm-4-air", "glm-4.5-flash", "codegeex-4" }, -- your desired model (or use gpt-4o, etc.)
					-- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
				},
				volceengine = {
					__inherited_from = "openai",
					endpoint = "https://ark.cn-beijing.volces.com/api/v3",
					api_key_name = "cmd:secret-tool lookup model_provider volceengine",
					model = "ep-20250301061622-8pclj", -- Deepseek V3
					extra_request_body = {
						max_tokens = 2048, -- to avoid using max_completion_tokens
					},
				},
			},
			web_search_engine = {
				provider = "serpapi", -- tavily, serpapi, searchapi, google or kagi
			},
			behavior = {
				-- enable_cursor_planning_mode = true,
			},
			input = {
				provider = "snacks",
				provider_opts = {
					-- Additional snacks.input options
					title = "Avante Input",
					icon = " ",
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"folke/snacks.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"folke/which-key.nvim",
			-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
			-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			-- "zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		init = function()
			local wk = require("which-key")

			-- prefil edit window with common scenarios to avoid repeating query and submit immediately
			local prefill_edit_window = function(request)
				require("avante.api").edit()
				local code_bufnr = vim.api.nvim_get_current_buf()
				local code_winid = vim.api.nvim_get_current_win()
				if code_bufnr == nil or code_winid == nil then
					return
				end
				vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
				-- Optionally set the cursor position to the end of the input
				vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
				-- Simulate Ctrl+S keypress to submit
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
			end

			-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
			local avante_grammar_correction =
				"Correct the text to standard English, but keep any code blocks inside intact."
			local avante_keywords = "Extract the main keywords from the following text"
			local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
			local avante_optimize_code = "Optimize the following code"
			local avante_summarize = "Summarize the following text"
			local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
			local avante_explain_code = "Explain the following code"
			local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
			local avante_add_docstring = "Add docstring to the following codes"
			local avante_fix_bugs = "Fix the bugs inside the following codes if any"
			local avante_add_tests = "Implement tests for the following code"

			wk.add({
				{ "<space>a", group = "Avante" }, -- NOTE: add for avante.nvim
				{
					mode = { "n", "v" },
					{
						"<space>ag",
						function()
							require("avante.api").ask({ question = avante_grammar_correction })
						end,
						desc = "Grammar Correction(ask)",
					},
					{
						"<space>ak",
						function()
							require("avante.api").ask({ question = avante_keywords })
						end,
						desc = "Keywords(ask)",
					},
					{
						"<space>al",
						function()
							require("avante.api").ask({ question = avante_code_readability_analysis })
						end,
						desc = "Code Readability Analysis(ask)",
					},
					{
						"<space>ao",
						function()
							require("avante.api").ask({ question = avante_optimize_code })
						end,
						desc = "Optimize Code(ask)",
					},
					{
						"<space>am",
						function()
							require("avante.api").ask({ question = avante_summarize })
						end,
						desc = "Summarize text(ask)",
					},
					{
						"<space>an",
						function()
							require("avante.api").ask({ question = avante_translate })
						end,
						desc = "Translate text(ask)",
					},
					{
						"<space>ax",
						function()
							require("avante.api").ask({ question = avante_explain_code })
						end,
						desc = "Explain Code(ask)",
					},
					{
						"<space>ac",
						function()
							require("avante.api").ask({ question = avante_complete_code })
						end,
						desc = "Complete Code(ask)",
					},
					{
						"<space>ad",
						function()
							require("avante.api").ask({ question = avante_add_docstring })
						end,
						desc = "Docstring(ask)",
					},
					{
						"<space>ab",
						function()
							require("avante.api").ask({ question = avante_fix_bugs })
						end,
						desc = "Fix Bugs(ask)",
					},
					{
						"<space>au",
						function()
							require("avante.api").ask({ question = avante_add_tests })
						end,
						desc = "Add Tests(ask)",
					},
				},
			})

			wk.add({
				{ "<space>a", group = "Avante" }, -- NOTE: add for avante.nvim
				{
					mode = { "v" },
					{
						"<space>aG",
						function()
							prefill_edit_window(avante_grammar_correction)
						end,
						desc = "Grammar Correction",
					},
					{
						"<space>aK",
						function()
							prefill_edit_window(avante_keywords)
						end,
						desc = "Keywords",
					},
					{
						"<space>aO",
						function()
							prefill_edit_window(avante_optimize_code)
						end,
						desc = "Optimize Code(edit)",
					},
					{
						"<space>aC",
						function()
							prefill_edit_window(avante_complete_code)
						end,
						desc = "Complete Code(edit)",
					},
					{
						"<space>aD",
						function()
							prefill_edit_window(avante_add_docstring)
						end,
						desc = "Docstring(edit)",
					},
					{
						"<space>aB",
						function()
							prefill_edit_window(avante_fix_bugs)
						end,
						desc = "Fix Bugs(edit)",
					},
					{
						"<space>aU",
						function()
							prefill_edit_window(avante_add_tests)
						end,
						desc = "Add Tests(edit)",
					},
				},
			})
		end,
	},
}
