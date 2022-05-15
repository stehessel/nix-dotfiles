return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
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
