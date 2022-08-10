return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").sqls.setup({
      on_attach = function(client)
        on_attach(client)
        client.server_capabilities.executeCommandProvider = true
        require("sqls").setup({ picker = "telescope" })
      end,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
