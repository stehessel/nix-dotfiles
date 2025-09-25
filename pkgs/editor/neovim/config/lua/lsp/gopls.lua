return {
  setup = function(on_attach, flags)
    vim.lsp.config("gopls", {
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
