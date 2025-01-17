return {
  setup = function(on_attach, flags)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
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
