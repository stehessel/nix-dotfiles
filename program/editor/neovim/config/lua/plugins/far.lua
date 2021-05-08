vim.g["far#source"] = "rgnvim"

require("vimp")
vimp.nnoremap({"silent"}, "<leader>F", ":Farr<cr>")
vimp.xnoremap({"silent"}, "<leader>F", ":Farr<cr>")

vim.o.regexpengine = 1
vim.g["far#enable_undo"] = 1
vim.g["far#glob_mode"] = "native"
