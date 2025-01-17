return {
  setup = function(on_attach, flags)
    require("lspconfig").terraformls.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
