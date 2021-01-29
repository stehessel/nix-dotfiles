-- Disable default mappings
vim.g.EasyMotion_do_mapping = 0

vimp.nmap({"silent"}, "s", "<Plug>(easymotion-overwin-f2)")

vim.g.EasyMotion_smartcase = 1

vimp.nmap({"silent"}, "<leader>h", "<Plug>(easymotion-linebackward)")
vimp.nmap({"silent"}, "<leader>J", "<Plug>(easymotion-j)")
vimp.nmap({"silent"}, "<leader>K", "<Plug>(easymotion-k)")
vimp.nmap({"silent"}, "<leader>l", "<Plug>(easymotion-lineforward)")
