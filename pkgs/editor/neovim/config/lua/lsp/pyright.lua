return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = {
        python = {
          analysis = {
            autoImportCompletions = true,
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "off",
            useLibraryCodeForTypes = false,
          },
        },
      },
    })
  end,
}
