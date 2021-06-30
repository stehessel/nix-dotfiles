return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    require("lspconfig").efm.setup({
      init_options = { documentFormatting = true },
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
      settings = {
        rootMarkers = { ".git/", ".root" },
        languages = {
          css = { require("plugins.lsp.efm.prettier") },
          dockerfile = { require("plugins.lsp.efm.hadolint") },
          fish = { require("plugins.lsp.efm.fish_indent") },
          html = { require("plugins.lsp.efm.prettier") },
          json = {
            require("plugins.lsp.efm.prettier"),
            require("plugins.lsp.efm.spectral"),
          },
          jsonc = {
            require("plugins.lsp.efm.prettier"),
            require("plugins.lsp.efm.spectral"),
          },
          lua = { require("plugins.lsp.efm.selene"), require("plugins.lsp.efm.stylua") },
          markdown = { require("plugins.lsp.efm.prettier") },
          python = {
            require("plugins.lsp.efm.black"),
            require("plugins.lsp.efm.flake8"),
            require("plugins.lsp.efm.isort"),
          },
          scss = { require("plugins.lsp.efm.prettier") },
          sh = { require("plugins.lsp.efm.shellcheck"), require("plugins.lsp.efm.shfmt") },
          sql = { require("plugins.lsp.efm.pg-format") },
          yaml = { require("plugins.lsp.efm.prettier") },
        },
      },
    })
  end,
}
