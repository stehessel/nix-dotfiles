vim.o.completeopt = "menu,menuone,noselect"

require("compe").setup {
  enabled = true,
  debug = false,
  min_length = 1,
  preselect = "always",
  allow_prefix_unmatch = false,

  source = {path = true, buffer = true, vsnip = true, nvim_lsp = true, nvim_lua = {}},
}

-- vim.nvim_exec([[
-- if s:default
--   inoremap <silent><expr> <C-Space> compe#complete()
--   inoremap <silent><expr> <CR>      compe#confirm('<CR>')
--   inoremap <silent><expr> <C-e>     compe#close('<C-e>')
-- endif
--
-- if s:lexima
--   inoremap <silent><expr> <C-Space> compe#complete()
--   inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
--   inoremap <silent><expr> <C-e>     compe#close('<C-e>')
-- endif
-- ]], false)
