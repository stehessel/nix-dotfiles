return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = {
        gopls = {
          gofumpt = true,
          semanticTokens = true,
        },
      },
    })
  end,
}
