local on_attach = function(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr })

  vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename, { buffer = bufnr })

  vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  vim.keymap.set("n", "<Space>f", function()
    vim.lsp.buf.format({ async = false })
  end, { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("lsp-overloads").setup(client, {
      keymaps = {
        next_signature = "<C-j>",
        previous_signature = "<C-k>",
        next_parameter = "<C-l>",
        previous_parameter = "<C-h>",
      },
    })
  end

  -- Callstack
  vim.keymap.set("n", "<Space>ci", vim.lsp.buf.incoming_calls, { buffer = bufnr })
  vim.keymap.set("n", "<Space>co", vim.lsp.buf.outgoing_calls, { buffer = bufnr })
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local flags = { debounce_text_changes = 150 }

      local servers = {
        "ansiblels",
        "bashls",
        "bufls",
        "dockerls",
        "gopls",
        "groovyls",
        "helm_ls",
        "jsonls",
        "jsonnet_ls",
        "luals",
        "marksman",
        "nil",
        "pyright",
        -- "sqls",
        "tailwindcss",
        "taplo",
        "terraformls",
        "tsserver",
        "yamlls",
      }
      for _, name in ipairs(servers) do
        require("lsp." .. name).setup(on_attach, capabilities, flags)
      end
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
        "nvimtools/none-ls.nvim",
        config = function()
          local builtins = require("null-ls").builtins

          require("null-ls").setup({
            on_attach = on_attach,
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
              builtins.diagnostics.cue_fmt,
              builtins.diagnostics.protolint,
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
              builtins.formatting.buf,
              builtins.formatting.cbfmt.with({
                args = {
                  "--config",
                  os.getenv("XDG_CONFIG_HOME") .. "/cbfmt/cbfmt.toml",
                  "--stdin-filepath",
                  "$FILENAME",
                  "--best-effort",
                },
              }),
              builtins.formatting.cue_fmt,
              builtins.formatting.cueimports,
              builtins.formatting.fish_indent,
              builtins.formatting.isort,
              builtins.formatting.prettierd,
              builtins.formatting.protolint,
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
      {
        "lewis6991/hover.nvim",
        config = function()
          require("hover").setup({
            init = function()
              require("hover.providers.lsp")
              require("hover.providers.gh")
              require("hover.providers.gh_user")
              require("hover.providers.jira")
            end,
            preview_opts = {
              border = nil,
            },
            preview_window = false,
            title = true,
          })

          vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
          vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
        end,
      },
    },
  },
}
