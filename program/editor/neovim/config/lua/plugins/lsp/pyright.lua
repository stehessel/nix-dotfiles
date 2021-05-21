return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      settings = {
        python = {analysis = {typeCheckingMode = "basic", useLibraryCodeForTypes = true}},
      },
    })
  end,
}
