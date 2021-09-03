-- dofile("/Users/lgtf/dev/neovim/profiler.nvim/lua/profiler.lua")
-- Set before loading plugins
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.opt.bg = "dark"
vim.opt.termguicolors = true

-- Disable builtin plugins
vim.g.loaded_gzip = false
vim.g.loaded_tar = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_matchit = false
vim.g.loaded_matchparen = false
vim.g.loaded_spec = false

require("plugins")
