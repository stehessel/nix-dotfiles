return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").marksman.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = {
        formatting = {
          command = "alejandra",
        },
      },
    })
  end,
}
