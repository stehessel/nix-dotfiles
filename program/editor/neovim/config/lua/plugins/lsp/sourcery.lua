return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    if not require("lspconfig").sourcery then
      require("lspconfig/configs").sourcery = {
        default_config = {
          cmd = { "/Users/lgtf/miniconda3/bin/sourcery", "lsp" },
          filetypes = { "python" },
          init_options = {
            token = "user_n80vzPEXsMA5mzvpZ25FPpNqbMGX_F_V696MKkMbrQtU9B7ZFj390TX8_GI",
            extension_version = "neovim",
            editor_version = "vim",
          },
          settings = {
            sourcery = {
              token = "user_n80vzPEXsMA5mzvpZ25FPpNqbMGX_F_V696MKkMbrQtU9B7ZFj390TX8_GI",
              metricsEnabled = true,
            },
          },
        },
      }
    end
    require("lspconfig").sourcery.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
