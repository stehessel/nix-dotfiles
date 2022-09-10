return {
  setup = function(on_attach, capabilities, flags)
    local cfg = require("yaml-companion").setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    })
    require("lspconfig").yamlls.setup(cfg)
  end,
}
