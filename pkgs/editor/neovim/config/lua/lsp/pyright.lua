return {
  setup = function(on_attach, flags)
    vim.lsp.config("pyright", {
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
