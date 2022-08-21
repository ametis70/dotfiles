require("twilight").setup({
	treesitter = true,
	expand = {
		"function",
		"method",
		"table",
		"if_statement",
	},
})

local wk = require("which-key")

wk.register({
	t = {
		t = { "<cmd>Twilight<CR>", "Twilight" },
	},
}, {
	prefix = "<leader>",
})
