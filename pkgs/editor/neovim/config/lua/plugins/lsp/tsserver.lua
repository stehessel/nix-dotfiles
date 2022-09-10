return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").tsserver.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({ eslint_bin = "eslint_d" })
        -- required to fix code action ranges
        ts_utils.setup_client(client)

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
