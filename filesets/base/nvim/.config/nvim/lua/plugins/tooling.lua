require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"shellcheck",
		"shfmt",
		"editorconfig-checker",
		"eslint_d",
		"prettierd",
		"flake8",
		"black",
	},
})
