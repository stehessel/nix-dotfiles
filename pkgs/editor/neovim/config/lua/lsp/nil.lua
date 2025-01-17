return {
  setup = function(on_attach, flags)
    require("lspconfig").nil_ls.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
