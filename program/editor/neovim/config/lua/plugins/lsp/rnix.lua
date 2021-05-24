return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").rnix.setup({ on_attach = on_attach, root_dir = root_patterns })
  end,
}
