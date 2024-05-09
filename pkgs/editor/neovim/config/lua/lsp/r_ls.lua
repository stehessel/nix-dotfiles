return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").r_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
