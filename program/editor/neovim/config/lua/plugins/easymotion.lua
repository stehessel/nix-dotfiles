-- Disable default mappings
vim.g.EasyMotion_do_mapping = 0

vimp.nmap("s", "<Plug>(easymotion-overwin-f2)")

vim.g.EasyMotion_smartcase = 1

vimp.nmap("<leader>J", "<Plug>(easymotion-j)")
vimp.nmap("<leader>K", "<Plug>(easymotion-k)")
