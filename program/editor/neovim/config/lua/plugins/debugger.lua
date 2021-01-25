vim.g.vimspector_enable_mappings = "HUMAN"
vim.g.vimspector_install_gadgets = {"debugpy", "CodeLLDB"}
vim.g.vimspector_sign_priority = {
  ["vimspectorBP"] = 50,
  ["vimspectorBPCond"] = 40,
  ["vimspectorBPDisabled"] = 30,
  ["vimspectorPC"] = 999,
}
