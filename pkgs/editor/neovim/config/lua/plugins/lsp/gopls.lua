return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
      settings = {
        gopls = {
          gofumpt = true,
        },
      },
    })
  end,
}
