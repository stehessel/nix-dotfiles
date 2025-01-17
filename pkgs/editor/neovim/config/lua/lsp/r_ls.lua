return {
  setup = function(on_attach, flags)
    require("lspconfig").r_language_server.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
