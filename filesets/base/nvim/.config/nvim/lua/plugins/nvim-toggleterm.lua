require("toggleterm").setup({
	hide_numbers = true,
	shade_terminals = true,
	start_in_insert = true,
	direction = "tab",
	close_on_exit = false,
})

local wk = require("which-key")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { noremap = true, silent = true })
	end,
})

wk.register({
	g = {
		l = {
			function()
				lazygit:toggle()
			end,
			"Open lazygit",
		},
	},
}, { prefix = "<leader>" })
