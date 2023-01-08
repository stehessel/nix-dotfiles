return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      filetypes = { "json", "jsonc" },
      init_options = { provideFormatter = false },
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    })
  end,
}
