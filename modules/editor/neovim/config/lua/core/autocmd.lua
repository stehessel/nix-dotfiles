-- Set correct terraform file type
-- local terraform = vim.api.nvim_create_augroup({"terraform"}, {clear = true})
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { command = "set filetype=terraform" })

vim.api.nvim_exec(
  [[
augroup terraform_filetype
    au!
    autocmd BufNewFile,BufRead *tf set filetype=terraform
augroup END
  ]],
  false
)
