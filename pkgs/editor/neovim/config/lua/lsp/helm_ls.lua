return {
  setup = function(on_attach, flags)
    require("lspconfig").helm_ls.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
