return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
      filetypes = { "json", "jsonc" },
      init_options = { provideFormatter = false },
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    })
  end,
}
