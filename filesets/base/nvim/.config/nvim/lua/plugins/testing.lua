local wk = require("which-key")

require("neotest").setup({
	adapters = {
		require("neotest-jest"),
		require("neotest-python"),
		require("neotest-go"),
	},
})

local run_current_test_keybiding = {
	function()
		require("neotest").run.run()
	end,
	"Current test",
}

local keybindings = {
	name = "Test",
	t = run_current_test_keybiding,
	T = {
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		"Current file",
	},
	d = {
		function()
			require("neotest").run.run({ strategy = "dap" })
		end,
		"Debug current test",
	},
	s = {
		function()
			require("neotest").run.stop()
		end,
		"Stop running test",
	},
	a = {
		function()
			require("neotest").run.attach()
		end,
		"Attach to running test",
	},
}

wk.register({
	r = {
		t = run_current_test_keybiding,
		T = keybindings,
	},
	c = {
		T = keybindings,
	},
}, {
	prefix = "<leader>",
})
