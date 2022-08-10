return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    local cfg = require("yaml-companion").setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    })
    require("lspconfig").yamlls.setup(cfg)
  end,
}
