return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").efm.setup({
      init_options = {documentFormatting = true},
      on_attach = on_attach,
      root_dir = root_patterns,
      settings = {
        rootMarkers = {".git/", ".root"},
        languages = {
          css = {require("plugins.lsp.efm.prettier")},
          dockerfile = {require("plugins.lsp.efm.hadolint")},
          html = {require("plugins.lsp.efm.prettier")},
          json = {
            require("plugins.lsp.efm.prettier"),
            require("plugins.lsp.efm.spectral"),
          },
          jsonc = {
            require("plugins.lsp.efm.prettier"),
            require("plugins.lsp.efm.spectral"),
          },
          lua = {require("plugins.lsp.efm.lua-format")},
          markdown = {require("plugins.lsp.efm.prettier")},
          python = {
            require("plugins.lsp.efm.black"),
            require("plugins.lsp.efm.flake8"),
            require("plugins.lsp.efm.isort"),
          },
          scss = {require("plugins.lsp.efm.prettier")},
          sh = {require("plugins.lsp.efm.shellcheck"), require("plugins.lsp.efm.shfmt")},
          sql = {require("plugins.lsp.efm.pg-format")},
          yaml = {require("plugins.lsp.efm.prettier")},
        },
      },
    })
  end,
}
