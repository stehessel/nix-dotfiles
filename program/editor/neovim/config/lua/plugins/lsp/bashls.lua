return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").bashls.setup({on_attach = on_attach, root_dir = root_patterns})
  end,
}
