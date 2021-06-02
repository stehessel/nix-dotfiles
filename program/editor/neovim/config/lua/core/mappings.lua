require("vimp")
require("core.settings")

-- Misc keybinds
vimp.nnoremap("U", ":redo<CR>")
vimp.nmap("Y", "y$")
vimp.nmap("vv", "V")
vimp.nnoremap({ "silent" }, "<leader>w", ":update<cr>")
vimp.nnoremap({ "silent" }, "<leader>q", ":quit<cr>")
vimp.nmap("?", ",")
-- vimp.nnoremap({"silent"}, "<C-l>", ":<C-u>nohl<cr><C-l>")
-- vimp.nnoremap("<plug>(slash-after)", "zz")
vimp.nnoremap("Q", "@q")

-- Yank whole buffer
vimp.nnoremap({ "silent" }, "<leader>Y", ":%y<cr>")
-- Select whole buffer
vimp.nnoremap({ "silent" }, "<leader>V", "ggVG")
-- Delete whole buffer
vimp.nnoremap({ "silent" }, "<leader>D", ":%d<cr>")
-- Visual mode
vimp.nnoremap({ "silent" }, "<M-v>", "<C-v>")
-- Disable highlight
vimp.nnoremap({ "silent" }, "<space>/", ":nohl<cr>")

-- Buffers
vimp.nnoremap({ "silent" }, "<leader>bn", ":bn<cr>")
vimp.nnoremap({ "silent" }, "<leader>bp", ":bp<cr>")
vimp.nnoremap({ "silent" }, "<leader>bd", ":bd<cr>")
-- Open alternative file
vimp.nnoremap({ "silent" }, "gj", "<C-^>")
-- Open alternative file in split
vimp.nnoremap({ "silent" }, "gk", ":vs#<cr>")

-- Splits
vimp.nmap({ "silent" }, "<C-h>", "<C-w>h")
vimp.nmap({ "silent" }, "<C-j>", "<C-w>j")
vimp.nmap({ "silent" }, "<C-k>", "<C-w>k")
vimp.nmap({ "silent" }, "<C-l>", "<C-w>l")
vimp.nmap({ "silent" }, "<C-S>", "<C-w>S")
vimp.nmap({ "silent" }, "<C-v>", "<C-w>v")
vimp.nmap({ "silent" }, "<C-p>", "<C-w>w")

-- Tabs
vimp.nnoremap({ "silent" }, "g[", ":-tabmove<cr>")
vimp.nnoremap({ "silent" }, "g]", ":+tabmove<cr>")
vimp.nnoremap({ "silent" }, "g^", ":tabm 0<cr>")
vimp.nnoremap({ "silent" }, "g$", ":tabm<cr>")
vimp.nnoremap({ "silent" }, "gq", ":tabclose<cr>")
vimp.nnoremap({ "silent" }, "<C-t>", ":tabnew<cr>")
vimp.nnoremap({ "silent" }, "<leader><space>", ":ToggleOnly<enter>")

-- Quickfix
vimp.nnoremap({ "silent" }, "<leader>co", ":copen<cr>")
vimp.nnoremap({ "silent" }, "<leader>cc", ":cclose<cr>")
vimp.nnoremap({ "silent" }, "<leader>cw", ":cw<cr>")
vimp.nnoremap({ "silent" }, "<leader>cn", ":cn<cr>")
vimp.nnoremap({ "silent" }, "<leader>cp", ":cp<cr>")
vim.cmd([[nnoremap <expr> <cr> &buftype ==# "quickfix" ? "\<cr>" : "za"]])

-- Line numbers
vimp.nnoremap({ "silent" }, "<leader>N", function()
  vim.opt.relativenumber = not vim.opt.relativenumber
end)

-- Spell-check set to <leader>o, 'o' for 'orthography'
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vimp.nnoremap({ "override", "silent" }, "<leader>o", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end)

-- Sort
vimp.xnoremap({ "override", "silent" }, "<leader>s", ":sort<cr>")

-- Terminal navigation
vimp.tnoremap({ "silent" }, "<C-q>", [[<C-\><C-n>:q<cr>]])
vimp.tnoremap({ "silent" }, "<C-h>", [[<C-\><C-n><C-w>h]])
vimp.tnoremap({ "silent" }, "<C-j>", [[<C-\><C-n><C-w>j]])
vimp.tnoremap({ "silent" }, "<C-k>", [[<C-\><C-n><C-w>k]])
vimp.tnoremap({ "silent" }, "<C-l>", [[<C-\><C-n><C-w>l]])
