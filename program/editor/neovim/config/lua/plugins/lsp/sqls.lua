return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").sqls.setup({
      on_attach = function(client)
        on_attach(client)
        client.resolved_capabilities.execute_command = true
        require("sqls").setup({ picker = "telescope" })
      end,
    })
  end,
}
