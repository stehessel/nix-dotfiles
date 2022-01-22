require("core.settings")
require("core.autocmd")

-- Misc keybinds
vim.keymap.set("n", "U", ":redo<CR>")
vim.keymap.set("n", "vv", "V")
vim.keymap.set("n", "<leader>w", ":update<CR>", {silent = true})
vim.keymap.set("n", "<leader>q", ":quit<CR>", {silent = true})
vim.keymap.set("n", "?", ",")
vim.keymap.set("n", "R", ":%s//g<Left><Left>")
vim.keymap.set("x", "R", ":s//g<Left><Left>")
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Center cursor
vim.keymap.set("n", "G", "Gzz")

-- Yank whole buffer
vim.keymap.set("n", "<leader>Y", ":%y<cr>")
-- Select whole buffer
vim.keymap.set("n", "<leader>V", "ggVG")
-- Delete whole buffer
vim.keymap.set("n", "<leader>D", ":%d<cr>")
-- Visual mode
vim.keymap.set("n", "<M-v>", "<C-v>")
-- Disable highlight
vim.keymap.set("n", "<Space>/", ":nohl<CR>")

-- Buffers
vim.keymap.set("n", "<Leader>bn", ":bn<CR>")
vim.keymap.set("n", "<Leader>bp", ":bp<CR>")
vim.keymap.set("n", "<Leader>bd", ":bd<CR>")
-- Open alternative file
vim.keymap.set("n", "gj", "<C-^>")
-- Open alternative file in split
vim.keymap.set("n", "gk", ":vs#<CR>")

-- Splits
vim.keymap.set("n", "<C-s>", "<C-w>s")
vim.keymap.set("n", "<C-v>", "<C-w>v")
vim.keymap.set("n", "<C-y>", "<C-w>w")

-- Tabs
vim.keymap.set("n", "g[", ":-tabmove<CR>")
vim.keymap.set("n", "g]", ":+tabmove<CR>")
vim.keymap.set("n", "g^", ":tabm 0<CR>")
vim.keymap.set("n", "g$", ":tabm<CR>")
vim.keymap.set("n", "gq", ":tabclose<CR>")
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
vim.keymap.set("n", "<Leader><Space>", ":ToggleOnly<enter>")

-- Quickfix
vim.keymap.set("n", "<Leader>co", ":copen<CR>")
vim.keymap.set("n", "<Leader>cc", ":cclose<CR>")
vim.keymap.set("n", "<Leader>cw", ":cw<CR>")
vim.keymap.set("n", "<Leader>cn", ":cn<CR>")
vim.keymap.set("n", "<Leader>cp", ":cp<CR>")
vim.cmd([[nnoremap <expr> <cr> &buftype ==# "quickfix" ? "\<cr>" : "za"]])

-- Line numbers
vim.keymap.set("n", "<Leader>N", function()
  vim.opt.relativenumber = not vim.opt.relativenumber
end)

-- Spell-check set to <leader>o, 'o' for 'orthography'
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.keymap.set("n", "<leader>o", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end)

-- Terminal navigation
vim.keymap.set("t", "<C-q>", [[<C-\><C-n>:q<cr>]])
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
