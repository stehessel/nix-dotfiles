return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    local coq = require("coq")
    require("lspconfig").pyright.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
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
    }))
  end,
}
