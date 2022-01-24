return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    if not require("lspconfig").sonarlint then
      require("lspconfig/configs").sonarlint = {
        default_config = { cmd = { "nc", "-l", "6008" }, filetypes = { "python" } },
      }
    end
    require("lspconfig").sonarlint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}