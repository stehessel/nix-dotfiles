return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").jsonnet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
