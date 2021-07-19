return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").tsserver.setup({
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
      end,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
