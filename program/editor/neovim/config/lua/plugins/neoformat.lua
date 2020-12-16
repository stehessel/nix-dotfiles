require("vimp")

-- vim.cmd [[augroup format]]
-- vim.cmd [[autocmd!]]
-- vim.cmd [[autocmd BufWritePre *.lua,*.py,*.sql undojoin | Neoformat]]
-- vim.cmd [[augroup END]]

vim.g.neoformat_enabled_json = {"prettier"}
vim.g.neoformat_enabled_lua = {"luafmt"}
vim.g.neoformat_enabled_python = {"black"}
vim.g.neoformat_enabled_sql = {"pg_format"}
vim.g.neoformat_enabled_yaml = {"prettier"}

vimp.nnoremap({"silent"}, "<leader>F", ":Neoformat<cr>")
