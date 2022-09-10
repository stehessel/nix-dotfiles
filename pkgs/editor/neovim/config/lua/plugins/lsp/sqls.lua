return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").sqls.setup({
      on_attach = function(client)
        on_attach(client)
        client.server_capabilities.executeCommandProvider = true
        require("sqls").setup({ picker = "telescope" })
      end,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
