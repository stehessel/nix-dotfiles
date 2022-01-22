return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    require("lspconfig").sqls.setup({
      on_attach = function(client)
        on_attach(client)
        client.resolved_capabilities.execute_command = true
        require("sqls").setup({ picker = "telescope" })
      end,
      root_dir = root_patterns,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
