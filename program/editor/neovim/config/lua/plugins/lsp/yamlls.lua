return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").yamlls.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
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
