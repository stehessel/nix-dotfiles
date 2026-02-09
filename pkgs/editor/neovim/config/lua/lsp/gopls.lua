return {
  setup = function(on_attach, flags)
    vim.lsp.config("gopls", {
      on_attach = on_attach,
      flags = flags,
      settings = {
        gopls = {
          buildFlags = { "-tags=compliance,sql_integration,test_e2e" },
          -- allowModfileModifications = true,
          gofumpt = true,
          semanticTokens = true,
        },
      },
    })
  end,
}
