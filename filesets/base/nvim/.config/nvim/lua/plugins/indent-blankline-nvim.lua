vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"dashboard",
	"dashpreview",
	"coc-explorer",
	"startify",
	"vista",
	"sagahover",
	"lspinfo",
}

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

local wk = require("which-key")

wk.register({
	t = {
		i = { "<cmd>IndentBlanklineToggle<CR>", "Indent guides" },
	},
}, {
	prefix = "<leader>",
})
