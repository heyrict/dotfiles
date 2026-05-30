-- Indents and numbers
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.timeout = true
vim.opt.ttimeoutlen = 10
vim.opt.backspace = { indent = true, eol = true, start = true }
vim.opt.title = true
vim.opt.spell = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lua",
		"html",
		"xml",
		"json",
		"javascript",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"css",
		"yaml",
		"dart",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tex" },
	callback = function()
		vim.opt.filetype = "tex"
	end,
})

-- File encodings
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "ucs-bom", "utf-8", "shift-jis", "cp932", "cp936" }

-- Format options
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "pandoc", "markdown", "tex" },
	callback = function()
		vim.opt.linebreak = false
		vim.opt.formatoptions:append({ r = true, m = true, B = true })
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "just" },
	callback = function()
		vim.opt.expandtab = false
	end,
})

-- Additional remaps
vim.keymap.set("n", "gh", "<cmd>nohlsearch<cr>")

-- Theme
--- Initial background setting, credits: https://agentydragon.com/posts/2022-09-03-neovim-theme-switch.html
if vim.fn.executable("gsettings") == 0 then
	return
end

local color_scheme = vim.fn.system({ "gsettings", "get", "org.gnome.desktop.interface", "color-scheme" })
-- remove newline character from color_scheme
color_scheme = vim.fn.substitute(color_scheme, "\n", "", "")
-- Remove quote marks
color_scheme = vim.fn.substitute(color_scheme, "'", "", "g")

if color_scheme == "prefer-dark" then
	vim.cmd("set background=dark")
else
	-- With disabled night mode, value seems to be to 'default' on my system.
	vim.cmd("set background=light")
end

--- Switch light/dark theme
vim.keymap.set("n", "<leader>%", function()
	local curr = vim.o.background
	if curr == "light" then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
end)

-- Disable mouse
-- vim.opt.mouse = {}

-- Neovide
local function set_ime(args)
	if args.event:match("Enter$") then
		vim.g.neovide_input_ime = true
	else
		vim.g.neovide_input_ime = false
	end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	group = ime_input,
	pattern = "*",
	callback = set_ime,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
	group = ime_input,
	pattern = "[/\\?]",
	callback = set_ime,
})

vim.g.neovide_normal_opacity = 0.6

require("config.lazy")
