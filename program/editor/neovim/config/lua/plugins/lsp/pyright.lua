return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
      settings = {
        python = { analysis = { typeCheckingMode = "off" } },
      },
    })
  end,
}
