return {
  setup = function(on_attach, flags)
    require("lspconfig").gopls.setup({
      on_attach = on_attach,
      flags = flags,
      settings = {
        gopls = {
          -- allowModfileModifications = true,
          gofumpt = true,
          semanticTokens = true,
        },
      },
    })
  end,
}
