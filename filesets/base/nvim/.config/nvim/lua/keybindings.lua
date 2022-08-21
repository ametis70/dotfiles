local utils = require("utils")
utils.map("n", "<C-l>", "<cmd>noh<CR>") -- Clear highlights
utils.map("n", "]q", "<cmd>cn<CR>")
utils.map("n", "[q", "<cmd>cp<CR>")
