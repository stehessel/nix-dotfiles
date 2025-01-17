return {
  setup = function(on_attach, flags)
    require("lspconfig").eslint.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
