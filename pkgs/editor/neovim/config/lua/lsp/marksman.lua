return {
  setup = function(on_attach, flags)
    require("lspconfig").marksman.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
