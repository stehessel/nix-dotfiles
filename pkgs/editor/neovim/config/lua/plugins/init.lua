-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print(out)
  print("Downloading packer.nvim...")

  return
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "lewis6991/impatient.nvim" })
    use({ "nathom/filetype.nvim" })

    -- Utility
    use({
      "nvim-lua/plenary.nvim",
      module = "plenary",
    })
    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          signs = {
            add = {
              hl = "GitSignsAdd",
              text = "+",
              numhl = "GitSignsAddNr",
              linehl = "GitSignsAddLn",
            },
            change = {
              hl = "GitSignsChange",
              text = "*",
              numhl = "GitSignsChangeNr",
              linehl = "GitSignsChangeLn",
            },
            delete = {
              hl = "GitSignsDelete",
              text = "-",
              numhl = "GitSignsDeleteNr",
              linehl = "GitSignsDeleteLn",
            },
          },
          keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ["n ]c"] = {
              expr = true,
              "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
            },
            ["n [c"] = {
              expr = true,
              "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
            },

            ["n <leader>hs"] = '<cmd>lua require("gitsigns").stage_hunk()<CR>',
            ["n <leader>hu"] = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
            ["n <leader>hr"] = '<cmd>lua require("gitsigns").reset_hunk()<CR>',
            ["n <leader>hR"] = '<cmd>lua require("gitsigns").reset_buffer()<CR>',
            ["n <leader>hh"] = '<cmd>lua require("gitsigns").preview_hunk()<CR>',
            ["n <leader>hb"] = '<cmd>lua require("gitsigns").blame_line(true)<CR>',
            ["n <leader>hv"] = '<cmd>lua require("gitsigns").toggle_linehl()<CR>',

            -- Text objects
            ["o ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
            ["x ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
          },
        })
      end,
    })
    use({
      "f-person/git-blame.nvim",
      cmd = "GitBlameToggle",
      config = function()
        vim.g.gitblame_enabled = 0
        vim.g.gitblame_ignored_filetypes = { "neo-tree" }
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>B", "<Cmd>GitBlameToggle<CR>")
      end,
    })
    use({
      "rhysd/git-messenger.vim",
      cmd = "GitMessenger",
      setup = function()
        vim.keymap.set("n", "<Leader>m", "<cmd>GitMessenger<CR>")
      end,
    })
    use({
      "akinsho/git-conflict.nvim",
      config = function()
        require("git-conflict").setup()
      end,
    })
    -- Github
    use({
      "pwntester/octo.nvim",
      cmd = "Octo",
      config = function()
        require("octo").setup()
      end,
    })
    -- Finders
    use({
      "nvim-lua/telescope.nvim",
      config = function()
        local deps = {
          "telescope-dap.nvim",
          "telescope-fzf-native.nvim",
          "telescope-github.nvim",
          "telescope-project.nvim",
          "telescope-symbols.nvim",
          "telescope-ui-select.nvim",
        }
        for _, plugin in ipairs(deps) do
          if packer_plugins[plugin] and not packer_plugins[plugin].loaded then
            vim.cmd.packadd(plugin)
          end
        end

        local telescope = require("telescope")
        telescope.setup({
          defaults = {
            color_devicons = true,
            scroll_strategy = "cycle",
            prompt_prefix = "❯ ",
            selection_caret = "❯ ",
            mappings = { i = { ["<Esc>"] = require("telescope.actions").close } },
          },
          extensions = {
            fzf = {
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
          },
        })
        telescope.load_extension("fzf")
        telescope.load_extension("gh")
        telescope.load_extension("neoclip")
        telescope.load_extension("project")
        telescope.load_extension("ui-select")
      end,
      module = "telescope",
      setup = function()
        vim.keymap.set("n", "<Leader>ff", "<Cmd>lua require('telescope.builtin').find_files()<CR>")
        vim.keymap.set("n", "<Leader>fr", "<Cmd>lua require('telescope.builtin').resume()<CR>")
        vim.keymap.set("n", "<Leader>fl", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
        vim.keymap.set("n", "<Leader>fL", "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
        vim.keymap.set("n", "<Leader>fb", "<Cmd>lua require('telescope.builtin').buffers()<CR>")
        vim.keymap.set("n", "<Leader>fh", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>")
        vim.keymap.set("n", "<Leader>fm", "<Cmd>lua require('telescope.builtin').marks()<CR>")
        vim.keymap.set("n", "<Leader>fc", "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>")
        vim.keymap.set("n", "<Leader>fv", "<Cmd>lua require('telescope.builtin').git_status()<CR>")
        vim.keymap.set("n", "<Leader>fg", "<Cmd>lua require('telescope.builtin').git_branches()<CR>")
        vim.keymap.set("n", "<Leader>fk", "<Cmd>lua require('telescope.builtin').keymaps()<CR>")
        vim.keymap.set("n", "<Leader>fs", "<Cmd>lua require('telescope.builtin').symbols()<CR>")
        vim.keymap.set("n", "<Leader>fo", "<Cmd>lua require('telescope.builtin').project()<CR>")
        vim.keymap.set("n", "<Leader>O", "<Cmd>lua require('telescope.builtin').spell_suggest()<CR>")

        vim.keymap.set("n", "<Leader>dc", "<Cmd>lua require('telescope').extensions.dap.commands({})<CR>")
        vim.keymap.set("n", "<Leader>db", "<Cmd>lua require('telescope').extensions.dap.list_breakpoints({})<CR>")
        vim.keymap.set("n", "<Leader>df", "<Cmd>lua require('telescope').extensions.dap.frames({})<CR>")
        vim.keymap.set("n", "<Leader>dv", "<Cmd>lua require('telescope').extensions.dap.variables({})<CR>")

        vim.keymap.set("n", "<Leader>fi", "<Cmd>lua require('telescope').extensions.gh.issues()<CR>")
        vim.keymap.set("n", "<Leader>fp", "<Cmd>lua require('telescope').extensions.gh.pull_request()<CR>")

        vim.keymap.set("n", "<Leader>y", "<Cmd>lua require('telescope').extensions.neoclip.neoclip()<CR>")

        vim.keymap.set("n", "<Leader>fy", "<Cmd>lua require('telescope').extensions.yaml_schema.yaml_schema()<CR>")

        vim.keymap.set("n", "gd", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
        vim.keymap.set("n", "gr", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>")
        vim.keymap.set("n", "gy", "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
        vim.keymap.set("n", "<Space>a", "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
        vim.keymap.set("x", "<Space>a", "<Cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>")
        vim.keymap.set("n", "<Space>o", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
        vim.keymap.set("n", "<Space>s", "<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")
        vim.keymap.set("n", "<Space>e", "<Cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>")
      end,
      requires = {
        { "nvim-telescope/telescope-dap.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", opt = true, run = "make" },
        { "nvim-telescope/telescope-github.nvim", opt = true },
        { "nvim-telescope/telescope-project.nvim", opt = true },
        { "nvim-telescope/telescope-symbols.nvim", opt = true },
        { "nvim-telescope/telescope-ui-select.nvim", opt = true },
      },
    })
    -- Clipboard
    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup({ enable_persistent_history = true, default_register = "+" })
        vim.g.sqlite_clib_path = os.getenv("LIB_SQLITE_PATH")
      end,
      requires = { "tami5/sqlite.lua", module = "sqlite" },
    })
    -- Todo
    use({
      "folke/todo-comments.nvim",
      cmd = "TodoTelescope",
      config = function()
        require("todo-comments").setup({})
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>")
      end,
    })
    -- Statusline
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("lualine").setup({
          options = { disabled_filetypes = { "Calltree", "NvimTree", "packer", "terminal" } },
          sections = {
            lualine_c = { "filename" },
          },
        })
      end,
      requires = { { "arkav/lualine-lsp-progress" } },
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end,
    })
    -- Notes
    use({
      "vhyrro/neorg",
      after = "nvim-treesitter",
      config = function()
        require("neorg").setup({
          load = {
            ["core.defaults"] = {},
            ["core.keybinds"] = {
              config = {
                default_keybinds = true,
                neorg_leader = "<Leader>n",
              },
            },
            ["core.norg.concealer"] = {},
            ["core.norg.dirman"] = {
              config = {
                tags = {
                  my_workspace = "~/doc/neorg",
                },
              },
            },
          },
        })
      end,
      ft = "norg",
      run = ":Neorg sync-parsers",
      disable = false,
    })
    use({
      "kristijanhusak/orgmode.nvim",
      config = function()
        require("orgmode").setup_ts_grammar()
        require("orgmode").setup({
          org_agenda_files = { "~/doc/org/*" },
          org_default_notes_file = "~/doc/org/refile.org",
        })
      end,
      disable = true,
    })
    -- LSP
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lsp")
      end,
    })
    use({
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
    })
    use({ "Issafalcon/lsp-overloads.nvim" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
    use({ "onsails/lspkind-nvim" })
    use({
      "someone-stole-my-name/yaml-companion.nvim",
      requires = {
        { "neovim/nvim-lspconfig" },
        { "nvim-telescope/telescope.nvim" },
      },
      config = function()
        require("telescope").load_extension("yaml_schema")
      end,
    })
    use({
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
    })
    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")

        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
          formatting = {
            format = lspkind.cmp_format({
              with_text = true,
              menu = {
                fuzzy_buffer = "[Buf]",
                git = "[Git]",
                luasnip = "[Snip]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                orgmode = "[Org]",
                path = "[Path]",
              },
            }),
          },
          mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end,
            ["<S-Tab>"] = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          sources = cmp.config.sources({
            { name = "path" },
            { name = "orgmode" },
            { name = "luasnip" },
            { name = "nvim_lua" },
            { name = "nvim_lsp" },
            { name = "git" },
            { name = "fuzzy_buffer" },
          }),
        })
        cmp.setup.filetype("gitcommit", {
          sources = cmp.config.sources({
            { name = "git" },
            { name = "fuzzy_buffer" },
          }),
        })
        require("cmp_git").setup()
      end,
      requires = {
        { "L3MON4D3/LuaSnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-path" },
        { "petertriho/cmp-git" },
        { "saadparwaiz1/cmp_luasnip" },
      },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } })
    use({
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").setup({
          bind = true,
          hint_enable = false,
          handler_opts = { border = "none" },
        })
      end,
      disable = true,
    })
    use({
      "ldelossa/litee-calltree.nvim",
      config = function()
        require("litee.lib").setup({})
        require("litee.calltree").setup({ layout_size = 40, icons = "codicon" })
      end,
      requires = { "ldelossa/litee.nvim" },
    })
    use({ "b0o/schemastore.nvim" })
    -- Doc strings
    use({
      "danymat/neogen",
      after = "nvim-treesitter",
      config = function()
        require("neogen").setup({
          enabled = true,
        })
        vim.keymap.set("n", "<Leader>j", require("neogen").generate, { desc = "Neogen - generate" })
      end,
    })
    use({ "nanotee/sqls.nvim", ft = "sql" })
    -- Python
    use({ "stsewd/sphinx.nvim", ft = { "python", "rst" } })
    use({
      "dccsillag/magma-nvim",
      cmd = { "MagmaInit" },
      setup = function()
        vim.keymap.set("n", "<localleader>ri", ":MagmaInit<CR>")
        vim.keymap.set("n", "<localleader>r", "nvim_exec('MagmaEvaluateOperator', v:true)", { expr = true })
        vim.keymap.set("x", "<localleader>r", ":<C-u>MagmaEvaluateVisual<CR>")
        vim.keymap.set("n", "<localleader>rl", ":MagmaEvaluateLine<CR>")
        vim.keymap.set("n", "<localleader>rc", ":MagmaReevaluateCell<CR>")
        vim.keymap.set("n", "<localleader>rd", ":MagmaDelete<CR>")
      end,
      run = ":UpdateRemotePlugins",
    })
    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter")
      end,
      run = vim.cmd.TSUpdate,
    })
    use({
      "RRethy/nvim-treesitter-textsubjects",
      after = "nvim-treesitter",
    })
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    })
    use({
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
    })
    use({
      "ThePrimeagen/refactoring.nvim",
      after = "nvim-treesitter",
      config = function()
        require("refactoring").setup({
          prompt_func_return_type = {
            go = true,
          },
          prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
          },
        })

        vim.keymap.set("v", "<Leader>re", "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>")
        vim.keymap.set(
          "v",
          "<Leader>rf",
          "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>"
        )
        vim.keymap.set("v", "<Leader>rv", "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>")
        vim.keymap.set("v", "<Leader>ri", "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>")
      end,
    })
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
    use({ "David-Kunz/markid" })
    -- Debugger
    use({
      "mfussenegger/nvim-dap",
      module = "dap",
      config = function()
        require("dap")
        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

        require("dap").defaults.fallback.exception_breakpoints = { "raised", "uncaught" }

        require("telescope").load_extension("dap")
      end,
      setup = function()
        vim.keymap.set("n", "<F2>", "<Cmd>lua require('dap').pause()<CR>")
        vim.keymap.set("n", "<F3>", "<Cmd>lua require('dap').require('dap').terminate()<CR>")
        vim.keymap.set("n", "<F4>", "<Cmd>lua require('dap').require('dap').restart()<CR>")
        vim.keymap.set("n", "<F5>", "<Cmd>lua require('dap').require('dap').continue()<CR>")
        vim.keymap.set("n", "<F6>", "<Cmd>lua require('dap').require('dap').up()<CR>")
        vim.keymap.set("n", "<F7>", "<Cmd>lua require('dap').require('dap').down()<CR>")
        vim.keymap.set("n", "<F8>", "<Cmd>lua require('dap').require('dap').run_to_cursor()<CR>")
        vim.keymap.set("n", "<F9>", "<Cmd>lua require('dap').toggle_breakpoint()<CR>")
        vim.keymap.set("n", "<Leader><F9>", function()
          require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vim.keymap.set("n", "<Localleader><F9>", function()
          require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end)
        vim.keymap.set("n", "<F10>", "<Cmd>lua require('dap').step_over()<CR>")
        vim.keymap.set("n", "<F11>", "<Cmd>lua require('dap').step_into()<CR>")
        vim.keymap.set("n", "<F12>", "<Cmd>lua require('dap').step_out()<CR>")
        vim.keymap.set("n", "<Leader>dr", "<Cmd>lua require('dap').repl.toggle<CR>")
        vim.keymap.set("n", "<Leader>dh", "<Cmd>lua require('dap.ui.widgets').hover()<CR>")
      end,
    })
    use({
      "rcarriga/nvim-dap-ui",
      after = "nvim-dap",
      config = function()
        require("dapui").setup()
        vim.keymap.set("n", "<Leader>du", require("dapui").toggle)
      end,
    })
    use({
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      config = function()
        vim.g.dap_virtual_text = true
      end,
    })
    use({
      "mfussenegger/nvim-dap-python",
      after = "nvim-dap",
      config = function()
        require("dap-python").setup("python", {})
        require("dap-python").test_runner = "pytest"
      end,
      filetype = "python",
    })
    use({
      "leoluz/nvim-dap-go",
      after = "nvim-dap",
      config = function()
        require("dap-go").setup()
      end,
      filetype = "go",
    })
    -- Testing
    use({
      "nvim-neotest/neotest",
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-go")({
              experimental = {
                test_table = true,
              },
            }),
            require("neotest-plenary"),
            require("neotest-python")({
              dap = {
                justMyCode = true,
              },
            }),
          },
        })
      end,
      module = "neotest",
      setup = function()
        vim.keymap.set("n", "<Leader>tt", "<Cmd>lua require('neotest').run.run()<CR>")
        vim.keymap.set("n", "<Leader>tf", "<Cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
        vim.keymap.set("n", "<Leader>td", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>")
        vim.keymap.set("n", "<Leader>tl", "<Cmd>lua require('neotest').run.run_last()<CR>")
        vim.keymap.set("n", "<Leader>ta", "<Cmd>lua require('neotest').run.run({suite = true})<CR>")
        vim.keymap.set("n", "<Leader>tx", "<Cmd>lua require('neotest').run.stop()<CR>")
        vim.keymap.set("n", "<Leader>ts", "<Cmd>lua require('neotest').summary.toggle()<CR>")
        vim.keymap.set("n", "<Leader>tm", "<Cmd>lua require('neotest').summary.run_marked()<CR>")
        vim.keymap.set("n", "<Leader>to", "<Cmd>lua require('neotest').output.open()<CR>")
      end,
      requires = {
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-plenary",
        "nvim-neotest/neotest-python",
      },
    })
    -- Tasks
    use({
      "EthanJWright/vs-tasks.nvim",
      config = function()
        require("vstask").setup({
          use_harpoon = false,
          telescope_keys = {
            vertical = "<C-v>",
            split = "<C-p>",
            tab = "<C-t>",
            current = "<CR>",
          },
          terminal = "toggleterm",
          term_opts = {
            vertical = {
              direction = "vertical",
              size = "80",
            },
            horizontal = {
              direction = "horizontal",
              size = "10",
            },
            current = {
              direction = "float",
            },
            tab = {
              direction = "tab",
            },
          },
        })
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>rr", "<Cmd>lua require('telescope').extensions.vstask.tasks()<CR>")
        vim.keymap.set("n", "<Leader>ri", "<Cmd>lua require('telescope').extensions.vstask.inputs()<CR>")
        vim.keymap.set("n", "<Leader>rc", "<Cmd>lua require('telescope').extensions.vstask.close()<CR>")
      end,
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
    })
    -- Code folding
    use({ "kalekundert/vim-coiled-snake", ft = "python" })
    use({ "Konfekt/FastFold" })
    -- Syntax highlighters
    use({ "ekalinin/Dockerfile.vim", ft = "dockerfile" })
    use({ "LnL7/vim-nix", ft = "nix" })
    use({ "RRethy/vim-illuminate" })
    -- Asciidoc
    use({ "habamax/vim-asciidoctor", ft = "asciidoctor" })
    -- Terminal
    use({
      "kassio/neoterm",
      cmd = { "T", "Texec", "Tmap", "Tnew", "Topen", "Ttoggle" },
      config = function()
        vim.g.neoterm_autoinsert = 1
        vim.g.neoterm_default_mod = "rightbelow vertical"
        vim.g.neoterm_shell = "fish"
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>Tt", ":Ttoggle<cr>")
        vim.keymap.set("n", "<Leader>Tr", ":TREPLSetTerm<cr>")
        vim.keymap.set("n", "<Leader>Tf", ":TREPLSendFile<cr>")
        vim.keymap.set("n", "<Leader>Tl", ":TREPLSendLine<cr>")
        vim.keymap.set("x", "<Leader>Tl", ":TREPLSendSelection<cr>")
        vim.keymap.set({ "n", "x" }, "gx", "<Plug>neoterm-repl-send")
      end,
    })
    use({
      "numtostr/FTerm.nvim",
      config = function()
        vim.keymap.set("n", "<Leader>G", function()
          local gitui = require("FTerm"):new({
            cmd = "gitui",
            dimensions = {
              height = 0.9,
              width = 0.9,
            },
          })
          gitui:toggle()
        end)
      end,
    })
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("toggleterm").setup()
      end,
    })
    use({
      "Olical/conjure",
      config = function()
        vim.g["conjure#log#hud#width"] = 0.42
      end,
      ft = { "clojure", "fennel" },
    })
    use({
      "michaelb/sniprun",
      setup = function()
        vim.keymap.set("n", "<Leader>nr", "<Cmd>lua require('sniprun').run()<CR>")
        vim.keymap.set("x", "<Leader>nr", "<Cmd>lua require('sniprun').run('v')<CR>")
        vim.keymap.set("n", "<Leader>nc", "<Cmd>lua require('sniprun.display').close_all()<CR>")
        vim.keymap.set("n", "<Leader>nx", "<Cmd>lua require('sniprun').reset()<CR>")
        vim.keymap.set("n", "<Leader>ni", "<Cmd>lua require('sniprun').info()<CR>")
      end,
      module = "sniprun",
      run = "bash ./install.sh",
    })
    -- Color scheme
    use({
      "catppuccin/nvim",
      as = "catppuccin",
      run = ":CatppuccinCompile",
      config = function()
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup({
          compile = {
            enabled = true,
          },
          integrations = {
            leap = true,
            neotree = {
              enabled = true,
              show_root = true,
              transparent_panel = false,
            },
            dap = {
              enabled = true,
              enable_ui = true,
            },
            which_key = true,
          },
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    })
    -- Icons
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    })
    use({
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker")
      end,
      setup = function()
        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<Leader>i", "<Cmd>PickIcons<CR>", opts)
        vim.keymap.set("i", "<Localleader>i", "<Cmd>PickIconsInsert<CR>", opts)
        vim.keymap.set("i", "<A-i>", "<Cmd>PickAltFontAndSymbolsInsert<CR>", opts)
      end,
    })
    -- Extend % operator
    use({
      "monkoose/matchparen.nvim",
      config = function()
        require("matchparen").setup()
      end,
    })
    -- Brackets
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
      end,
      disable = true,
      event = "InsertEnter",
    })
    use({
      "ur4ltz/surround.nvim",
      config = function()
        require("surround").setup({ prefix = "r" })
      end,
      disable = false,
    })
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          keymaps = {
            insert = "ys",
            visual = "S",
            delete = "ds",
            change = "cs",
          },
        })
      end,
      disable = true,
    })
    -- Marks
    use({
      "chentoast/marks.nvim",
      config = function()
        require("marks").setup({ excluded_filetypes = { "neotest-summary" } })
      end,
    })
    -- Indentation
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.g.indent_blankline_buftype_exclude = { "nofile", "prompt", "terminal" }
        vim.g.indent_blankline_char = "¦"
        vim.g.indent_blankline_filetype_exclude = { "packer", "startify" }
        require("indent_blankline").setup({
          show_current_context = true,
          show_current_context_start = true,
        })
      end,
    })
    use({ "Darazaki/indent-o-matic", disable = true })
    use({
      "nmac427/guess-indent.nvim",
      config = function()
        require("guess-indent").setup({})
      end,
    })
    -- Keybinds
    use({ "tpope/vim-unimpaired" })
    -- Movement
    use({
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
    })
    use({
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup({
          keys = { f = "f", F = "F", t = "t", T = "T" },
          labeled_modes = "v",
          multiline = true,
          opts = {},
        })
      end,
    })
    use({
      "ggandor/leap-spooky.nvim",
      config = function()
        require("leap-spooky").setup({
          affixes = {
            window = "r",
            cross_window = "R",
          },
          yank_paste = false,
          opts = nil,
        })
      end,
      disable = true,
    })
    use({
      "mfussenegger/nvim-treehopper",
      after = "nvim-treesitter",
      module = "tsht",
      setup = function()
        vim.keymap.set("o", "m", ":<C-U>lua require('tsht').nodes()<CR>")
        vim.keymap.set("v", "m", "<Cmd>lua require('tsht').nodes()<CR>")
      end,
    })
    -- Text manipulation
    use({
      "AndrewRadev/switch.vim",
      cmd = "Switch",
      setup = function()
        vim.g.switch_mapping = ""
        vim.keymap.set("n", "-", "<Cmd>Switch<CR>")
      end,
    })
    use({
      "junegunn/vim-easy-align",
      cmd = "EasyAlign",
      setup = function()
        vim.keymap.set({ "n", "x" }, "ga", ":EasyAlign<CR>")
      end,
    })
    use({
      "tpope/vim-sexp-mappings-for-regular-people",
      after = "vim-sexp",
      ft = { "clojure", "fennel" },
    })
    use({
      "guns/vim-sexp",
      config = function()
        vim.g.sexp_enable_insert_mode_mappings = 0
      end,
      ft = { "clojure", "fennel" },
    })
    use({ "matze/vim-move" })
    use({ "mg979/vim-visual-multi", keys = { "<C-n>", "<C-Up>", "<C-Down>" } })
    use({
      "nicwest/vim-camelsnek",
      cmd = { "Camel", "CamelB", "Kebab", "Snek" },
      setup = function()
        vim.keymap.set({ "n", "x" }, "<Leader>xs", "<Cmd>Snek<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xc", "<Cmd>Camel<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xb", "<Cmd>CamelB<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xk", "<Cmd>Kebab<CR>")
      end,
    })
    use({ "tpope/vim-repeat", keys = "." })
    use({
      "sQVe/sort.nvim",
      cmd = "Sort",
      config = function()
        require("sort").setup({})
      end,
      setup = function()
        vim.keymap.set("n", "go", "<Cmd>Sort<CR>")
        vim.keymap.set("v", "go", "<Esc><Cmd>Sort<CR>")
      end,
    })
    -- Increment / Decrement
    use({
      "monaqa/dial.nvim",
      setup = function()
        vim.keymap.set({ "n", "x" }, "<C-a>", "<Plug>(dial-increment)")
        vim.keymap.set({ "n", "x" }, "<C-x>", "<Plug>(dial-decrement)")
        vim.keymap.set("n", "g<C-a>", "<Plug>(dial-increment-additional)")
        vim.keymap.set("n", "g<C-x>", "<Plug>(dial-decrement-additional)")
      end,
      keys = {
        "<Plug>(dial-increment)",
        "<Plug>(dial-decrement)",
        "<Plug>(dial-increment-additional)",
        "<Plug>(dial-decrement-additional)",
      },
    })
    -- Comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    -- Text substitution
    use({
      "gbprod/substitute.nvim",
      module = "substitute",
      config = function()
        require("substitute").setup({})
      end,
      setup = function()
        -- Substitute
        vim.keymap.set(
          "n",
          "<Leader>s",
          "<Cmd>lua require('substitute').operator()<CR>",
          { desc = "Substitute with motion", noremap = true }
        )
        vim.keymap.set(
          "n",
          "<Leader>ss",
          "<Cmd>lua require('substitute').line()<CR>",
          { desc = "Substitute line", noremap = true }
        )
        vim.keymap.set(
          "n",
          "<Leader>sl",
          "<Cmd>lua require('substitute').eol()<CR>",
          { desc = "Substitute to end of line", noremap = true }
        )
        vim.keymap.set(
          "x",
          "<Leader>s",
          "<Cmd>lua require('substitute').visual()<CR>",
          { desc = "Substitute selection", noremap = true }
        )

        -- Exchange
        vim.keymap.set(
          "n",
          "<Leader>sx",
          "<Cmd>lua require('substitute.exchange').operator()<CR>",
          { desc = "Exchange with motion", noremap = true }
        )
        vim.keymap.set(
          "n",
          "<Leader>sxx",
          "<Cmd>lua require('substitute.exchange').line()<CR>",
          { desc = "Substitute line", noremap = true }
        )
        vim.keymap.set(
          "x",
          "<Leader>X",
          "<Cmd>lua require('substitute.exchange').visual()<CR>",
          { desc = "Exchange selected", noremap = true }
        )
        vim.keymap.set(
          "n",
          "<Leader>sxc",
          "<Cmd>lua require('substitute.exchange').cancel()<CR>",
          { desc = "Cancel exchange", noremap = true }
        )
      end,
    })
    -- Text objects
    use("wellle/targets.vim")
    -- Buffers
    use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })
    use({
      "wfxr/minimap.vim",
      cmd = "MinimapToggle",
      setup = function()
        vim.keymap.set("n", "<Leader>C", "<Cmd>MinimapToggle<CR>")
      end,
    })
    -- Keymaps
    use({
      "anuvyklack/hydra.nvim",
      requires = "anuvyklack/keymap-layer.nvim",
      config = function()
        local Hydra = require("hydra")
        local gitsigns = require("gitsigns")

        local hint = [[
 _J_: next hunk    _s_: stage hunk         _d_: show deleted    _b_: blame line
 _K_: prev hunk    _u_: undo stage hunk    _p_: preview hunk    _B_: blame show full
 ^ ^               _S_: stage buffer       ^ ^                  _/_: show base file
 ^
 _<Enter>_: Gitui  _q_: exit
        ]]

        Hydra({
          hint = hint,
          config = {
            color = "pink",
            invoke_on_body = true,
            hint = {
              position = "bottom",
              border = "rounded",
            },
            on_enter = function()
              vim.bo.modifiable = false
              gitsigns.toggle_signs(true)
              gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
              gitsigns.toggle_signs(false)
              gitsigns.toggle_linehl(false)
              gitsigns.toggle_deleted(false)
              vim.cmd.echo() -- clear the echo area
            end,
          },
          mode = { "n", "x" },
          body = "<leader>g",
          heads = {
            {
              "J",
              function()
                if vim.wo.diff then
                  return "]c"
                end
                vim.schedule(function()
                  gitsigns.next_hunk()
                end)
                return "<Ignore>"
              end,
              { expr = true },
            },
            {
              "K",
              function()
                if vim.wo.diff then
                  return "[c"
                end
                vim.schedule(function()
                  gitsigns.prev_hunk()
                end)
                return "<Ignore>"
              end,
              { expr = true },
            },
            { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
            { "u", gitsigns.undo_stage_hunk },
            { "S", gitsigns.stage_buffer },
            { "p", gitsigns.preview_hunk },
            { "d", gitsigns.toggle_deleted, { nowait = true } },
            { "b", gitsigns.blame_line },
            {
              "B",
              function()
                gitsigns.blame_line({ full = true })
              end,
            },
            { "/", gitsigns.show, { exit = true } }, -- show the base of the file
            {
              "<Enter>",
              function()
                local gitui = require("FTerm"):new({
                  cmd = "gitui",
                  dimensions = {
                    height = 0.9,
                    width = 0.9,
                  },
                })
                gitui:toggle()
              end,
              { exit = true },
            },
            { "q", nil, { exit = true, nowait = true } },
          },
        })
      end,
    })
    -- Zen
    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      config = function()
        require("zen-mode").setup({})
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>z", "<Cmd>ZenMode<CR>")
      end,
    })
    -- Tabs
    use("gcmt/taboo.vim")
    -- Tmux
    use({
      "numToStr/Navigator.nvim",
      module = "Navigator",
      config = function()
        require("Navigator").setup({})
      end,
      setup = function()
        vim.keymap.set("n", "<C-h>", "<Cmd>lua require('Navigator').left()<CR>")
        vim.keymap.set("n", "<C-j>", "<Cmd>lua require('Navigator').down()<CR>")
        vim.keymap.set("n", "<C-k>", "<Cmd>lua require('Navigator').up()<CR>")
        vim.keymap.set("n", "<C-l>", "<Cmd>lua require('Navigator').right()<CR>")
        vim.keymap.set("n", "<C-p>", "<Cmd>lua require('Navigator').previous()<CR>")
      end,
    })
    -- File explorer
    use({
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeOpen", "NvimTreeToggle" },
      config = function()
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_group_empty = 1
        vim.g.nvim_tree_highlight_opened_files = 1
        vim.g.nvim_tree_special_files = {
          ["MAKEFILE"] = 1,
          ["Makefile"] = 1,
          ["README"] = 1,
          ["README.MD"] = 1,
          ["README.md"] = 1,
          ["flake.nix"] = 1,
        }
        vim.g.nvim_tree_width = 40

        require("nvim-tree").setup({
          hijack_cursor = true,
          update_cwd = true,
          diagnostics = {
            enable = true,
            icons = {
              hint = " ",
              info = " ",
              warning = " ",
              error = " ",
            },
          },
          renderer = {
            indent_markers = { enable = true },
          },
          update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
          },
          view = {
            mappings = {
              custom_only = false,
              list = {
                {
                  key = { "<CR>", "l", "<2-LeftMouse>" },
                  cb = require("nvim-tree.config").nvim_tree_callback("edit"),
                },
              },
            },
          },
          filters = {
            custom = {
              ".DS_Store",
              ".directory",
              ".git",
              ".idea",
              ".mypy_cache",
              ".ropeproject",
              ".vim",
              ".vscode",
              "__pycache__",
              "dask-worker-space",
              "thumbs.db",
            },
          },
        })
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>")
      end,
      disable = true,
    })
    use({
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      cmd = { "Neotree" },
      config = function()
        -- Unless you are still migrating, remove the deprecated commands from v1.x
        vim.g.neo_tree_remove_legacy_commands = 1

        require("neo-tree").setup({
          close_if_last_window = false,
          window = {
            mappings = {
              ["l"] = "open",
            },
            width = 40,
          },
          filesystem = {
            follow_current_file = true,
            group_empty_dirs = true,
            use_libuv_file_watcher = true,
          },
        })
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>e", ":Neotree reveal toggle<CR>")
      end,
      requires = {
        "kyazdani42/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
      disable = false,
    })
    -- Projects
    use({
      "tpope/vim-projectionist",
      config = function()
        vim.g.projectionist_heuristics = {
          ["data_catalog/*.py"] = { ["alternate"] = "tests/unit/test_{}.py" },
        }
      end,
    })
    -- Search
    use({
      "windwp/nvim-spectre",
      config = function()
        require("spectre").setup({
          mapping = {
            ["send_to_qf"] = {
              map = "<leader>Q",
              cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
              desc = "send all item to quickfix",
            },
          },
          is_insert_mode = true,
        })
      end,
      module = "spectre",
      setup = function()
        vim.keymap.set("n", "<Leader>S", "<Cmd>lua require('spectre').open()<CR>", { desc = "Spectre - open" })
        vim.keymap.set(
          "v",
          "<leader>S",
          "<Cmd>lua require('spectre').open_visual()<CR>",
          { desc = "Spectre - open visual" }
        )
        vim.keymap.set(
          "n",
          "<localleader>S",
          "<Cmd>lua require('spectre').open_file_search()<CR>",
          { desc = "Spectre - open current file" }
        )
      end,
    })
    use({
      "cshuaimin/ssr.nvim",
      module = "ssr",
      config = function()
        require("ssr").setup({
          min_width = 50,
          min_height = 5,
          keymaps = {
            close = "q",
            next_match = "n",
            prev_match = "N",
            replace_all = "<leader><cr>",
          },
        })
      end,
      setup = function()
        vim.keymap.set({ "n", "x" }, "<leader>sr", function()
          require("ssr").open()
        end)
      end,
    })
    use({
      "inkarkat/vim-SearchAlternatives",
      keys = "/",
      requires = "inkarkat/vim-ingo-library",
    })
    use({ "romainl/vim-cool" })
    use({
      "ironhouzi/starlite-nvim",
      module = "starlite",
      setup = function()
        vim.keymap.set("n", "*", "<Cmd>lua require('starlite').star()<CR>")
        vim.keymap.set("n", "g*", "<Cmd>lua require('starlite').g_star()<CR>")
        vim.keymap.set("n", "#", "<Cmd>lua require('starlite').hash()<CR>")
        vim.keymap.set("n", "g#", "<Cmd>lua require('starlite').g_hash()<CR>")
      end,
    })
    -- Discover keybinds
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end,
    })
    -- Save position
    use({
      "ethanholz/nvim-lastplace",
      config = function()
        require("nvim-lastplace").setup({
          lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
          lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
          lastplace_open_folds = true,
        })
      end,
    })
    -- Root directory
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup({})
      end,
    })
    -- Filetypes
    use({ "isobit/vim-caddyfile", ft = "caddyfile" })
    use({ "towolf/vim-helm" })
    -- Notifications
    use({ "rcarriga/nvim-notify" })
    -- Neovim utility
    use({
      "antoinemadec/FixCursorHold.nvim",
      config = function()
        vim.g.cursorhold_update = 100
      end,
    })
  end,
  config = {
    -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    max_jobs = 32,
    profile = { enable = false, threshold = 1 },
  },
})
