-- Set correct terraform file type
vim.api.nvim_exec(
  [[
augroup terraform_filetype
    au!
    autocmd BufNewFile,BufRead *tf set filetype=terraform
augroup END
  ]],
  false
)
