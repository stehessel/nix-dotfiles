return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = {
        gopls = {
          allowModfileModifications = true,
          gofumpt = true,
          semanticTokens = true,
        },
      },
    })
  end,
}
