require("vimp")

-- Misc keybinds
vimp.nnoremap("U", ":redo<CR>")
vimp.nmap("Y", "y$")
vimp.nnoremap("<leader>s", ":w<cr>")
vimp.nnoremap("<leader>q", ":q<cr>")
vimp.nnoremap("?", ",")
-- vimp.nnoremap({"silent"}, "<C-l>", ":<C-u>nohl<cr><C-l>")
-- vimp.nnoremap("<plug>(slash-after)", "zz")
vimp.imap({"silent"}, "<C-d>", [[<C-R>=strftime("%Y-%m-%d")<cr>]])
vimp.nnoremap("Q", "@q")
