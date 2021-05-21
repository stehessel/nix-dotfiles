return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").dockerls.setup({on_attach = on_attach, root_dir = root_patterns})
  end,
}
