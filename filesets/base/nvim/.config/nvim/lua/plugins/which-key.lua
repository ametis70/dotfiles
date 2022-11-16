local wk = require("which-key")

wk.setup()

wk.register({
  f = {
    name = "File",
    C = {
      function()
        vim.api.nvim_input(":Copy " .. vim.fn.expand("%"))
      end,
      "Copy file",
    },
    R = {
      function()
        vim.api.nvim_input(":Move " .. vim.fn.expand("%"))
      end,
      "Rename/move file",
    },
    D = {
      function()
        vim.api.nvim_input(":Delete")
      end,
      "Delete file",
    },
    P = {
      function()
        print(vim.fn.expand("%:p"))
      end,
      "Print absolute path",
    },
  },
  b = {
    name = "Buffer",
    d = { "<cmd>bdel<CR>", "Delete buffer" },
    s = { "<cmd>write<CR>", "Save buffer" },
  },
  c = {
    name = "Code",
  },
  h = {
    name = "Help",
  },
  p = {
    name = "Project",
  },
  n = {
    name = "Note",
  },
  t = {
    name = "Toggle",
  },
  g = {
    name = "Git",
  },
  r = {
    name = "Run",
  },
  o = {
    name = "Open",
    t = { '<cmd>exe v:count1 . "ToggleTerm"<CR>', "Open terminal" },
    T = { "<cmd>terminal<CR>", "Open terminal here" },
  },
  w = {
    name = "Window",
    d = { "<cmd>close<CR>", "Close window" },
    v = { "<cmd>vsplit<CR>", "Vertical split" },
    s = { "<cmd>split<CR>", "Horizontal split" },
  },
  q = {
    name = "Quit",
    q = { "<cmd>qa<CR>", "Quit nvim" },
  },
}, {
  prefix = "<leader>",
})
