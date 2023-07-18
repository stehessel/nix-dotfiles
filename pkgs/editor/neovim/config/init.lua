-- Set before loading plugins
vim.loader.enable()
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

require("core.mappings")

-- Set up plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  concurrency = 64,
  defaults = { lazy = true },
})
