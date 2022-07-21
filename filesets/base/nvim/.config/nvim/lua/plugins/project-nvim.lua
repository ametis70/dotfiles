require("project_nvim").setup {
    manual_mode = false,
    detection_methods = {"lsp", "pattern"},
    patterns = {
        ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json",
        ".luarc.json"
    },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = true,
    silent_chdir = true,
    datapath = vim.fn.stdpath("data")
}
