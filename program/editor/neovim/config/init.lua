-- dofile("/Users/lgtf/dev/neovim/profiler.nvim/lua/profiler.lua")
-- Set before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.opt.bg = "dark"
vim.opt.termguicolors = true

require("plugins")
