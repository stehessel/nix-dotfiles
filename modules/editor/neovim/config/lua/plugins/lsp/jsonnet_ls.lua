return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").jsonnet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
