return {
  setup = function(on_attach, flags)
    local cfg = require("yaml-companion").setup({
      on_attach = on_attach,
      flags = flags,
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- an external SchemaStore plugin and its advanced options like `ignore`.
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length').
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    })
    require("lspconfig").yamlls.setup(cfg)
  end,
}
