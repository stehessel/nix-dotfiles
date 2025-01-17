return {
  setup = function(on_attach, flags)
    require("lspconfig").sqls.setup({
      on_attach = function(client)
        on_attach(client)
        client.server_capabilities.executeCommandProvider = true
        require("sqls").setup({ picker = "telescope" })
      end,
      flags = flags,
    })
  end,
}
