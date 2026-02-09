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
      local flags = { debounce_text_changes = 150 }

      local servers = {
        "ansiblels",
        "bashls",
        "buf_ls",
        "dockerls",
        "eslint",
        "gopls",
        "groovyls",
        "helm_ls",
        "jsonls",
        "jsonnet_ls",
        "luals",
        "marksman",
        "nixd",
        "pyright",
        "r_ls",
        -- "sqls",
        "systemd_lsp",
        "tailwindcss",
        "taplo",
        "terraformls",
        "tsserver",
        "yamlls",
      }
      for _, name in ipairs(servers) do
        require("lsp." .. name).setup(on_attach, flags)
      end
      vim.lsp.enable(servers)
    end,
    event = "VeryLazy",
    dependencies = {
      {
        "someone-stole-my-name/yaml-companion.nvim",
      },
      {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
          {
            "<Space>f",
            function()
              require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
          },
        },
        -- This will provide type hinting with LuaLS
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
          formatters_by_ft = {
            bash = { "shfmt" },
            css = { "prettierd", "prettier", stop_after_first = true },
            cue = { "cue_fmt" },
            fish = { "fish_indent" },
            graphql = { "prettierd", "prettier", stop_after_first = true },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            jsx = { "prettierd", "prettier", stop_after_first = true },
            lua = { "stylua" },
            nix = { "alejandra" },
            proto = { "buf" },
            python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
            sh = { "shfmt" },
            sql = { "sql_formatter" },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
          },
          default_format_opts = {
            lsp_format = "fallback",
          },
          formatters = {
            shfmt = {
              prepend_args = { "-i", "2" },
            },
            stylua = {
              prepend_args = {
                "--config-path",
                os.getenv("HOME") .. "/.config/stylua/stylua.toml",
              },
            },
          },
        },
        init = function()
          vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
              builtins.code_actions.gomodifytags,
              builtins.code_actions.refactoring,
              builtins.code_actions.statix,
              builtins.diagnostics.actionlint,
              builtins.diagnostics.buf,
              builtins.diagnostics.checkmake,
              builtins.diagnostics.codespell,
              builtins.diagnostics.cue_fmt,
              builtins.diagnostics.deadnix,
			  builtins.diagnostics.fish,
			  builtins.diagnostics.gitleaks,
              -- builtins.diagnostics.golangci_lint,
              builtins.diagnostics.hadolint,
			  builtins.diagnostics.kube_linter,
			  builtins.diagnostics.npm_groovy_lint,
              builtins.diagnostics.protolint,
              builtins.diagnostics.selene,
			  builtins.diagnostics.semgrep,
			  builtins.diagnostics.sqruff,
			  builtins.diagnostics.staticcheck,
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
        enabled = false,
      },
      { "b0o/SchemaStore.nvim" },
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
