local wk = require("which-key")

wk.register({
	o = {
		p = { "<cmd>NvimTreeToggle<CR>", "Open project sidebar" },
	},
}, {
	prefix = "<leader>",
})

require("nvim-tree").setup({
	auto_reload_on_write = true,
	create_in_closed_folder = false,
	disable_netrw = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_setup_file = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = true,
	reload_on_bufenter = false,
	respect_buf_cwd = true,

	ignore_ft_on_setup = {},
	hijack_cursor = false,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	view = {
		width = 30,
		side = "left",
		signcolumn = "no",
		mappings = {
			custom_only = false,
			list = {},
		},
	},
	renderer = {
		special_files = {},
		group_empty = false,
		highlight_git = true,
		icons = {
			git_placement = "before",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "",
					ignored = "",
				},
			},
		},
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})
