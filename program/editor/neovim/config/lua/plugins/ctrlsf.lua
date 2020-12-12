vim.g.ctrlsf_regex_pattern = 1
vim.g.ctrlsf_auto_focus = {["at"] = "done", ["duration_less_than"] = 5000}
vim.g.ctrlsf_default_root = "project"
vim.g.ctrlsf_search_mode = "async"
vim.g.ctrlsf_position = "right"
vim.g.ctrlsf_mapping = {["vsplit"] = "<C-v>"}

require("vimp")
vimp.nmap("<leader>jj", "<Plug>CtrlSFPrompt")
vimp.xmap({"silent"}, "<leader>jj", "<Plug>CtrlSFVwordExec")
vimp.xmap({"silent"}, "<leader>jJ", "<Plug>CtrlSFVwordPath")
vimp.nmap({"silent"}, "<leader>jn", "<Plug>CtrlSFCwordPath")
vimp.nmap({"silent"}, "<leader>jp", "<Plug>CtrlSFPwordPath")
vimp.nnoremap({"silent"}, "<leader>jo", ":CtrlSFOpen<cr>")
vimp.nnoremap({"silent"}, "<leader>jt", ":CtrlSFToggle<cr>")
