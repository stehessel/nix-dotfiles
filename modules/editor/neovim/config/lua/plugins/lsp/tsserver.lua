return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    require("lspconfig").tsserver.setup({
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({ eslint_bin = "eslint_d" })
        -- required to fix code action ranges
        ts_utils.setup_client(client)

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
