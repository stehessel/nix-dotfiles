return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").dockerls.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
