local wk = require("which-key")
require('orgmode').setup_ts_grammar()

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'org'},
        additional_vim_regex_highlighting = {'org'}
    },
    ensure_installed = {'org'}
}

require('orgmode').setup({
    org_agenda_files = {
        '~/.org/work/*', '~/org/learning/*', "~/.org/projects/*",
        "~/.org/calendars/*", "~/.org/conferences/*"
    },
    org_default_notes_file = '~/.org/refile.org'
})

local wk_open_org_agenda = {
    [[<cmd>lua require('orgmode').action("agenda.prompt")<CR>]], "Org agenda"
}

wk.register({
    n = {
        a = wk_open_org_agenda,
        f = {
            [[<cmd>lua require('telescope.builtin').find_files{ cwd = '~/.org' }<CR>]],
            "Find file in notes"
        },
        n = {
            [[<cmd>lua require('orgmode').action("capture.prompt")<CR>]],
            "Org capture"
        },
        s = {
            [[<cmd>lua require('telescope.builtin').live_grep{ cwd = '~/.org' }<CR>]],
            "Search notes"
        }
    },
    o = {
        a = wk_open_org_agenda
    }
}, {
    prefix = "<leader>"
})
