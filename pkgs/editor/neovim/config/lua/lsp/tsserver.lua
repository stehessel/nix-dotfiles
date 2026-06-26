return {
  setup = function(on_attach, flags)
    vim.lsp.config("ts_ls", {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      flags = flags,
    })
  end,
}
