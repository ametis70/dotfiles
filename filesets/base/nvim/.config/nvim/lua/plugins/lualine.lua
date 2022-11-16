local lualine = require("lualine")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		disabled_filetypes = { "NvimTree" },
		globalstatus = true,
		theme = {{colors.vim_lualine_theme}},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {},
		lualine_x = { "location", "progress" },
		lualine_y = { "diagnostics", "filetype" },
		lualine_z = {},
	},
}

table.insert(config.sections.lualine_c, {
	"filename",
	condition = conditions.buffer_not_empty,
	path = 1,
})

lualine.setup(config)
require("incline").setup()
