return {
	{
		"robitx/gp.nvim",
		config = function()
			local zhipu_key = { "secret-tool", "lookup", "url", "https://open.bigmodel.cn/api/paas/v4/" }
			local conf = {
				providers = {
					zhipu = {
						endpoint = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
						secret = zhipu_key,
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
						provider = "zhipu",
						name = "glm-4-plus",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4-plus", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "zhipu",
						name = "glm-4-air",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4-air", temperature = 0.95, top_p = 0.7 },
						-- system prompt (use this to specify the persona/role of the AI)
						system_prompt = require("gp.defaults").chat_system_prompt,
					},
					{
						provider = "zhipu",
						name = "glm-4-flash",
						chat = true,
						command = true,
						-- string with model name or table with model name and parameters
						model = { model = "glm-4-flash", temperature = 0.95, top_p = 0.7 },
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
				},
				default_command_agent = "glm-4-flash",
				default_chat_agent = "glm-4-flash",
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
							.. "请在细阅全文并确保理解论文核心观点的基础上，细致调整表述，采用更为精准和学术化的词汇替换原有语句，同时确保不改变原意，以增强论文的专业性和学术性。请直接给出修改后的全文，不要给出其它任何提示词。"
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
}
