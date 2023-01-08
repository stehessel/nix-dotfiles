return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp")
    end,
    event = "BufReadPre",
    dependencies = {
      {
        "someone-stole-my-name/yaml-companion.nvim",
        config = function()
          require("telescope").load_extension("yaml_schema")
        end,
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          local builtins = require("null-ls").builtins

          require("null-ls").setup({
            on_attach = require("plugins.lsp").on_attach,
            sources = {
              builtins.code_actions.gitsigns,
              builtins.code_actions.refactoring,
              builtins.code_actions.statix,
              builtins.diagnostics.buf,
              builtins.diagnostics.codespell,
              builtins.diagnostics.deadnix,
              builtins.diagnostics.eslint.with({ command = "eslint_d" }),
              -- builtins.diagnostics.golangci_lint,
              builtins.diagnostics.hadolint,
              builtins.diagnostics.selene,
              builtins.diagnostics.shellcheck,
              builtins.diagnostics.statix,
              builtins.diagnostics.vale.with({
                args = function(params)
                  return {
                    "--config",
                    os.getenv("XDG_CONFIG_HOME") .. "/vale/vale.ini",
                    "--no-exit",
                    "--output",
                    "JSON",
                    "--ext",
                    "." .. vim.fn.fnamemodify(params.bufname, ":e"),
                  }
                end,
              }),
              builtins.formatting.alejandra,
              builtins.formatting.black,
              builtins.formatting.cbfmt.with({
                args = {
                  "--config",
                  os.getenv("XDG_CONFIG_HOME") .. "/cbfmt/cbfmt.toml",
                  "--stdin-filepath",
                  "$FILENAME",
                  "--best-effort",
                },
              }),
              builtins.formatting.fish_indent,
              builtins.formatting.isort,
              builtins.formatting.prettierd,
              builtins.formatting.shfmt,
              builtins.formatting.sql_formatter,
              builtins.formatting.stylua.with({
                args = {
                  "--config-path",
                  os.getenv("HOME") .. "/.config/stylua/stylua.toml",
                  "-",
                },
              }),
            },
          })
        end,
      },
      { "Issafalcon/lsp-overloads.nvim" },
      { "jose-elias-alvarez/nvim-lsp-ts-utils" },
      { "onsails/lspkind-nvim" },
      {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
          require("lsp-inlayhints").setup()

          vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
          vim.api.nvim_create_autocmd("LspAttach", {
            group = "LspAttach_inlayhints",
            callback = function(args)
              if not (args.data and args.data.client_id) then
                return
              end

              local bufnr = args.buf
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              require("lsp-inlayhints").on_attach(client, bufnr)
            end,
          })
        end,
        event = "LspAttach",
      },
      { "b0o/schemastore.nvim" },
      { "nanotee/sqls.nvim", ft = "sql" },
    },
  },
}
