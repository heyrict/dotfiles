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

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "html", "json", "javascript", "typescript", "typescript.tsx", "css", "yaml", "dart" },
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
	pattern = { "pandoc", "markdown" },
	callback = function()
		vim.opt.linebreak = false
		vim.opt.formatoptions:append({ r = true, m = true, B = true })
	end,
})

-- Additional remaps
vim.keymap.set("n", "gh", "<cmd>nohlsearch<cr>")

-- Disable mouse
-- vim.opt.mouse = {}

require("config.lazy")
