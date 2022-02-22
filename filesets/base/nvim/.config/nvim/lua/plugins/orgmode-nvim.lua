require('orgmode').setup_ts_grammar()

require('orgmode').setup({
    org_agenda_files = {
        '~/.org/work/*', '~/org/learning/*', "~/.org/projects/*",
        "~/.org/calendars/*", "~/.org/conferences/*"
    },
    org_default_notes_file = '~/.org/refile.org'
})
