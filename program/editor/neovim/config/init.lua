-- dofile("/Users/lgtf/dev/neovim/profiler.nvim/lua/profiler.lua")
-- Set before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.opt.bg = "dark"
vim.opt.termguicolors = true

-- Disable builtin plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1

require("plugins")
