return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
      filetypes = { "json", "jsonc" },
      init_options = { provideFormatter = false },
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    })
  end,
}
