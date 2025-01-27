return {
  setup = function(on_attach, flags)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      flags = flags,
      init_options = { provideFormatter = false },
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    })
  end,
}
