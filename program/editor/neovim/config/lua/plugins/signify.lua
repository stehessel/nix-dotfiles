require("vimp")
vimp.nnoremap({"silent"}, "<leader>vl", ":SignifyList<cr>")
vimp.nnoremap({"silent"}, "<leader>vd", ":SignifyDiff<cr>")
vimp.nnoremap({"silent"}, "<leader>vf", ":SignifyFold<cr>")
vimp.nnoremap({"silent"}, "<leader>vv", ":SignifyHunkDiff<cr>")
vimp.nnoremap({"silent"}, "<leader>vu", ":SignifyHunkUndo<cr>")
vimp.nnoremap({"silent"}, "<leader>vr", ":SignifyRefresh<cr>")
vimp.nnoremap({"silent"}, "<leader>vt", ":SignifyToggle<cr>")
vimp.nnoremap({"silent"}, "<leader>vh", ":SignifyToggleHighlight<cr>")

vimp.omap({"silent"}, "ig", "<Plug>(signify-motion-inner-pending)")
vimp.xmap({"silent"}, "ig", "<Plug>(signify-motion-inner-visual)")
vimp.omap({"silent"}, "ag", "<Plug>(signify-motion-outer-pending)")
vimp.xmap({"silent"}, "ag", "<Plug>(signify-motion-outer-visual)")

vim.cmd [[highlight SignifySignDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
vim.cmd [[highlight SignifyLineDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
