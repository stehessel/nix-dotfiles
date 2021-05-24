return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").jsonls.setup({
      init_options = { provideFormatter = false },
      on_attach = on_attach,
      root_dir = root_patterns,
    })
  end,
}
