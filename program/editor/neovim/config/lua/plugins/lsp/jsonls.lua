return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").jsonls.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
      filetypes = { "json", "jsonc" },
      init_options = { provideFormatter = false },
    })
  end,
}
