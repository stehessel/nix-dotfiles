vim.g.ctrlsf_auto_focus = {["at"] = "done", ["duration_less_than"] = 5000}
vim.g.ctrlsf_backend = "rg"
vim.g.ctrlsf_default_root = "project"
vim.g.ctrlsf_extra_root_markers = {".root"}
vim.g.ctrlsf_mapping = {["vsplit"] = "<C-v>"}
vim.g.ctrlsf_position = "right"
vim.g.ctrlsf_regex_pattern = 1
vim.g.ctrlsf_search_mode = "async"

require("vimp")
vimp.nmap("<leader>jj", "<Plug>CtrlSFPrompt")
vimp.xmap("<leader>jj", "<Plug>CtrlSFVwordExec")
vimp.xmap("<leader>jJ", "<Plug>CtrlSFVwordPath")
vimp.nmap("<leader>jn", "<Plug>CtrlSFCwordPath")
vimp.nmap("<leader>jp", "<Plug>CtrlSFPwordPath")
vimp.nnoremap("<leader>jo", ":CtrlSFOpen<cr>")
vimp.nnoremap("<leader>jt", ":CtrlSFToggle<cr>")
