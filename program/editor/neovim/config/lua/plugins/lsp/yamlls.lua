return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").yamlls.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
      settings = {
        yaml = {
          schemas = {
            ["/Users/lgtf/git/sc-deploy/deploy/schemas/core-data-snapshotter/schema.json"] = {
              "/core_data_snapshotter.yml",
            },
          },
        },
      },
    })
  end,
}
