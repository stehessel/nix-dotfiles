return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    local builtins = require("null-ls").builtins
    local sources = {
      builtins.code_actions.gitsigns,
      builtins.diagnostics.eslint.with({ command = "eslint_d" }),
      builtins.diagnostics.flake8,
      builtins.diagnostics.hadolint,
      builtins.diagnostics.selene,
      builtins.diagnostics.shellcheck,
      builtins.formatting.black,
      builtins.formatting.isort,
      builtins.formatting.prettierd,
      builtins.formatting.shfmt,
      builtins.formatting.stylua.with({
        args = { "--config-path", vim.fn.expand("$HOME") .. "/.config/stylua/stylua.toml", "-" },
      }),
      require("plugins.lsp.null-ls.codespell"),
      require("plugins.lsp.null-ls.fish_indent"),
      require("plugins.lsp.null-ls.pg-format"),
    }

    require("null-ls").config({ sources = sources })
    require("lspconfig")["null-ls"].setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
