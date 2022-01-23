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
      config = function()
        vim.keymap.set("n", "<Leader>gB", "<cmd>GitBlameToggle<CR>")
      end,
    })
    use({
      "rhysd/git-messenger.vim",
      cmd = "GitMessenger",
      setup = function()
        vim.keymap.set("n", "<Leader>m", "<cmd>GitMessenger<CR>")
      end,
    })
    use({ "rhysd/conflict-marker.vim" })
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
      cmd = { "Octo", "Telescope" },
      config = function()
        local deps = {
          "telescope-dap.nvim",
          "telescope-fzf-native.nvim",
          "telescope-github.nvim",
          "telescope-project.nvim",
          "telescope-symbols.nvim",
        }
        for _, plugin in ipairs(deps) do
          if packer_plugins[plugin] and not packer_plugins[plugin].loaded then
            vim.cmd("packadd " .. plugin)
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
        if vim.bo.filetype == "python" then
          telescope.load_extension("dap")
        end
        telescope.load_extension("fzf")
        telescope.load_extension("gh")
        telescope.load_extension("neoclip")
        telescope.load_extension("project")

        vim.keymap.set("n", "<Leader>fg", function()
          local git_diff_branch = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            vim.cmd("DiffviewOpen " .. selection.value)
          end

          require("telescope.builtin").git_branches({
            attach_mappings = function(_, map)
              map("n", "<c-y>", git_diff_branch)
              map("i", "<c-y>", git_diff_branch)
              return true
            end,
          })
        end)
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
        vim.keymap.set("n", "<Leader>fr", "<Cmd>Telescope resume<CR>")
        vim.keymap.set("n", "<Leader>fl", "<Cmd>Telescope live_grep<CR>")
        vim.keymap.set("n", "<Leader>fL", "<Cmd>Telescope current_buffer_fuzzy_find<CR>")
        vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
        vim.keymap.set("n", "<Leader>fh", "<Cmd>Telescope oldfiles<CR>")
        vim.keymap.set("n", "<Leader>fm", "<Cmd>Telescope marks<CR>")
        vim.keymap.set("n", "<Leader>fc", "<Cmd>Telescope git_bcommits<CR>")
        vim.keymap.set("n", "<Leader>fv", "<Cmd>Telescope git_status<CR>")
        vim.keymap.set("n", "<Leader>fk", "<Cmd>Telescope keymaps<CR>")
        vim.keymap.set("n", "<Leader>fs", "<Cmd>Telescope symbols<CR>")
        vim.keymap.set("n", "<Leader>fo", "<Cmd>Telescope project<CR>")
        vim.keymap.set("n", "<Leader>O", "<Cmd>Telescope spell_suggest<CR>")

        vim.keymap.set("n", "<Leader>dc", "<Cmd>Telescope dap commands<CR>")
        vim.keymap.set("n", "<Leader>db", "<Cmd>Telescope dap list_breakpoints<CR>")
        vim.keymap.set("n", "<Leader>df", "<Cmd>Telescope dap frames<CR>")
        vim.keymap.set("n", "<Leader>dv", "<Cmd>Telescope dap variables<CR>")

        vim.keymap.set("n", "<Leader>fi", "<Cmd>Telescope gh issues<CR>")
        vim.keymap.set("n", "<Leader>fp", "<Cmd>Telescope gh pull_request<CR>")

        vim.keymap.set("n", "<Leader>y", "<Cmd>Telescope neoclip<CR>")

        vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>")
        vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>")
        vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_implementations<CR>")
        vim.keymap.set("n", "<Space>a", "<Cmd>Telescope lsp_code_actions<CR>")
        vim.keymap.set("x", "<Space>a", "<Cmd>Telescope lsp_range_code_actions<CR>")
        vim.keymap.set("n", "<Space>o", "<Cmd>Telescope lsp_document_symbols<CR>")
        vim.keymap.set("n", "<Space>s", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
        vim.keymap.set("n", "<Space>e", "<Cmd>Telescope diagnostics bufnr=0<CR>")
      end,
      requires = {
        { "nvim-telescope/telescope-dap.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", opt = true, run = "make" },
        { "nvim-telescope/telescope-github.nvim", opt = true },
        { "nvim-telescope/telescope-project.nvim", opt = true },
        { "nvim-telescope/telescope-symbols.nvim", opt = true },
      },
    })
    -- Clipboard
    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup({ enable_persistant_history = true, default_register = "+" })
      end,
      requires = { "tami5/sqlite.lua", module = "sqlite" },
    })
    -- Todo
    use({
      "folke/todo-comments.nvim",
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
            lualine_c = { "filename", "lsp_progress" },
          },
        })
      end,
      requires = { { "arkav/lualine-lsp-progress" } },
    })
    -- Notes
    use({
      "vhyrro/neorg",
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
      disable = true,
    })
    use({
      "kristijanhusak/orgmode.nvim",
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/doc/org/*" },
          org_default_notes_file = "~/doc/org/refile.org",
        })
      end,
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
            builtins.diagnostics.eslint.with({ command = "eslint_d" }),
            builtins.diagnostics.hadolint,
            builtins.diagnostics.selene,
            -- builtins.diagnostics.shellcheck,
            builtins.diagnostics.statix,
            builtins.formatting.black,
            builtins.formatting.fish_indent,
            builtins.formatting.isort,
            builtins.formatting.prettierd,
            builtins.formatting.shfmt,
            builtins.formatting.stylua.with({
              args = { "--config-path", vim.fn.expand("$HOME") .. "/.config/stylua/stylua.toml", "-" },
            }),
            require("plugins.lsp.null-ls.codespell"),
            require("plugins.lsp.null-ls.pgformatter"),
          },
        })
      end,
    })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
    use({
      "onsails/lspkind-nvim",
      config = function()
        require("lspkind").init()
      end,
    })
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
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "orgmode" },
          }, {
            { name = "fuzzy_buffer" },
            { name = "luasnip" },
          }, {
            { name = "path" },
          }),
        })
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
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
        vim.keymap.set("n", "<Leader>j", require("neogen").generate)
      end,
    })
    use({ "nanotee/sqls.nvim", ft = "sql" })
    -- Golang
    use({
      "ray-x/go.nvim",
      config = function()
        require("go").setup()

        vim.keymap.set("n", "<Leader>gf", "<Cmd>GoDebug file<CR>")
        vim.keymap.set("n", "<Leader>gt", "<Cmd>GoDebug test<CR>")
        vim.keymap.set("n", "<Leader>gn", "<Cmd>GoDebug nearest<CR>")
        vim.keymap.set("n", "<Leader>gs", "<Cmd>GoDebug stop<CR>")
        vim.keymap.set("n", "<Leader>ga", "<Cmd>GoAlt<CR>")
        vim.keymap.set("n", "<Leader>gv", "<Cmd>GoAltV<CR>")
      end,
      requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    })
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
    -- Clojure
    use({ "tpope/vim-fireplace", ft = "clojure", cmd = "FireplaceConnect" })
    -- Treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter")
      end,
      run = function()
        vim.cmd("TSUpdate")
      end,
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
    -- Debugger
    use({
      "mfussenegger/nvim-dap",
      config = function()
        require("dap")
        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

        require("dap").defaults.fallback.exception_breakpoints = { "raised", "uncaught" }

        vim.keymap.set("n", "<F2>", require("dap").repl.toggle)
        vim.keymap.set("n", "<F3>", require("dap").close)
        vim.keymap.set("n", "<F4>", require("dap").continue)
        vim.keymap.set("n", "<F5>", require("dap").run_to_cursor)
        vim.keymap.set("n", "<F6>", require("dap").up)
        vim.keymap.set("n", "<F7>", require("dap").down)
        vim.keymap.set("n", "<F8>", require("dap").toggle_breakpoint)
        vim.keymap.set("n", "<F9>", require("dap").repl.toggle)
        vim.keymap.set("n", "<Leader><F9>", function()
          require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vim.keymap.set("n", "<Localleader><F9>", function()
          require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end)
        vim.keymap.set("n", "<F10>", require("dap").step_over)
        vim.keymap.set("n", "<F11>", require("dap").step_into)
        vim.keymap.set("n", "<F12>", require("dap").step_out)
        vim.keymap.set("n", "<Leader>dh", require("dap.ui.widgets").hover)
      end,
      filetype = { "go", "python", "rust", "typescript" },
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
        require("dap-python").setup("python")
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
      "rcarriga/vim-ultest",
      after = "nvim-dap",
      config = function()
        vim.g.ultest_max_threads = 6
        vim.g.ultest_use_pty = 1

        require("ultest").setup({
          builders = {
            ["python#pytest"] = function(cmd)
              -- The command can start with python command directly or an env manager
              local non_modules = { "python", "pipenv", "poetry" }
              -- Index of the python module to run the test.
              local module, module_index
              if vim.tbl_contains(non_modules, cmd[1]) then
                module_index = 3
                module = cmd[module_index]
              else
                module_index = 1
                module = cmd[module_index]
              end
              -- Remaining elements are arguments to the module
              local args = vim.list_slice(cmd, module_index + 1)
              return {
                dap = {
                  type = "python",
                  request = "launch",
                  module = module,
                  args = args,
                },
              }
            end,
          },
        })
      end,
      setup = function()
        vim.keymap.set("n", "<Leader>tt", ":Ultest<CR>")
        vim.keymap.set("n", "<Leader>tl", ":UltestLast<CR>")
        vim.keymap.set("n", "<Leader>tn", ":UltestNearest<CR>")
        vim.keymap.set("n", "<Leader>ts", ":UltestSummary<CR>")
        vim.keymap.set("n", "<Leader>td", ":UltestDebug<CR>")
        vim.keymap.set("n", "<Leader>tD", ":UltestDebugNearest<CR>")
        vim.keymap.set("n", "<Leader>to", ":UltestOutput<CR>")
        vim.keymap.set("n", "<Leader>tc", ":UltestClear<CR>")
        vim.keymap.set("n", "<Leader>tj", "<Plug>(ultest-output-jump)")
        vim.keymap.set("n", "[t", "<Plug>(ultest-prev-fail)")
        vim.keymap.set("n", "]t", "<Plug>(ultest-next-fail)")
      end,
      run = ":UpdateRemotePlugins",
    })
    use({
      "janko/vim-test",
      config = function()
        vim.g["test#go#runner"] = "richgo"
        vim.g["test#python#runner"] = "pytest"
        vim.g["test#python#pytest#options#"] = { ["all"] = "--capture=no" }
      end,
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
    -- REPL
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
        local gitui = require("FTerm"):new({
          cmd = "gitui",
          dimensions = {
            height = 0.9,
            width = 0.9,
          },
        })

        vim.keymap.set("n", "<Leader>G", function()
          gitui:toggle()
        end)
      end,
    })
    use({
      "Olical/conjure",
      config = function()
        vim.cmd([[let g:conjure#log#hud#width = 0.42]])
      end,
      ft = { "clojure", "fennel" },
    })
    use({ "michaelb/sniprun", run = "bash ./install.sh" })
    -- Color scheme
    use({ "folke/lsp-colors.nvim" })
    use({
      "folke/tokyonight.nvim",
      config = function()
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_sidebars = { "Calltree", "NvimTree", "packer", "qf", "terminal" }
        vim.cmd("colorscheme tokyonight")
      end,
    })
    -- Icons
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
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
      "blackCauldron7/surround.nvim",
      config = function()
        require("surround").setup({ prefix = "r" })
      end,
    })
    -- Marks
    use({
      "chentau/marks.nvim",
      config = function()
        require("marks").setup({})
      end,
    })
    -- Indentation
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.g.indent_blankline_buftype_exclude = { "nofile", "prompt", "terminal" }
        vim.g.indent_blankline_char = "¦"
        vim.g.indent_blankline_filetype_exclude = { "packer", "startify" }
      end,
    })
    use({ "Darazaki/indent-o-matic" })
    -- Keybinds
    use({ "tpope/vim-unimpaired" })
    -- Movement
    use({
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup({ ignore_case = true })
      end,
    })
    use({
      "mfussenegger/nvim-treehopper",
      after = "nvim-treesitter",
      config = function()
        vim.keymap.set("o", "m", ":<C-U>lua require('tsht').nodes()<CR>")
        vim.keymap.set("v", "m", ":lua require('tsht').nodes()<CR>")
      end,
    })
    -- Text manipulation
    use({
      "AndrewRadev/switch.vim",
      setup = function()
        vim.g.switch_mapping = "-"
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
        vim.keymap.set({ "n", "x" }, "<Leader>xs", ":Snek<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xc", ":Camel<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xb", ":CamelB<CR>")
        vim.keymap.set({ "n", "x" }, "<Leader>xk", ":Kebab<CR>")
      end,
    })
    use({ "tpope/vim-repeat", keys = "." })
    use({
      "sQVe/sort.nvim",
      config = function()
        require("sort").setup({})
        vim.keymap.set({ "n", "x" }, "go", ":Sort<CR>")
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
      "svermeulen/vim-subversive",
      config = function()
        vim.cmd([[nmap <leader>s <Plug>(SubversiveSubstitute)]])
        vim.cmd([[nmap <leader>ss <Plug>(SubversiveSubstituteLine)]])
        vim.cmd([[nmap <leader>sl <Plug>(SubversiveSubstituteToEndOfLine)]])

        vim.cmd([[xmap <leader>s <Plug>(SubversiveSubstitute)]])
        vim.cmd([[xmap p <Plug>(SubversiveSubstitute)]])
        vim.cmd([[xmap P <Plug>(SubversiveSubstitute)]])

        vim.cmd([[nmap <leader><leader>s <Plug>(SubversiveSubvertRange)]])
        vim.cmd([[xmap <leader><leader>s <Plug>(SubversiveSubvertRange)]])
        vim.cmd([[nmap <leader><leader>ss <Plug>(SubversiveSubvertWordRange)]])

        vim.cmd([[nmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]])
        vim.cmd([[xmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]])
        vim.cmd([[nmap <leader>css <Plug>(SubversiveSubstituteWordRangeConfirm)]])

        -- ie = inner entire buffer
        vim.keymap.set("o", "ie", [[:exec "normal! ggVG"<CR>]])
        -- iv = current viewable text in the buffer
        vim.keymap.set("o", "iv", [[:exec "normal! HVL"<CR>]])
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
      config = function()
        require("Navigator").setup()

        vim.keymap.set("n", "<C-h>", require("Navigator").left)
        vim.keymap.set("n", "<C-j>", require("Navigator").down)
        vim.keymap.set("n", "<C-k>", require("Navigator").up)
        vim.keymap.set("n", "<C-l>", require("Navigator").right)
        vim.keymap.set("n", "<C-p>", require("Navigator").previous)
      end,
    })
    -- File explorer
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_group_empty = 1
        vim.g.nvim_tree_highlight_opened_files = 1
        vim.g.nvim_tree_width = 35

        require("nvim-tree").setup({
          hijack_cursor = true,
          update_cwd = true,
          diagnostics = {
            enable = true,
            icons = {
              hint = " ",
              info = " ",
              warning = " ",
              error = " ",
            },
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

        vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>")
      end,
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
        vim.keymap.set("n", "<Leader>S", require("spectre").open)
        vim.keymap.set("v", "<leader>S", require("spectre").open_visual)
        vim.keymap.set("n", "<localleader>S", require("spectre").open_file_search)
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
      config = function()
        vim.keymap.set("n", "*", require("starlite").star)
        vim.keymap.set("v", "g*", require("starlite").g_star)
        vim.keymap.set("n", "#", require("starlite").hash)
        vim.keymap.set("n", "g#", require("starlite").g_hash)
      end,
    })
    -- Discover keybinds
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end,
      disable = true, -- disabled due to breaking changes on neovim master
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
    -- Autosave
    use({
      "907th/vim-auto-save",
      setup = function()
        vim.g.auto_save = 0
        vim.g.auto_save_silent = 1
        vim.g.auto_save_events = { "InsertLeave", "FocusLost" }
      end,
    })
    -- Filetypes
    use({ "isobit/vim-caddyfile", ft = "caddyfile" })
    -- Notifications
    use({ "rcarriga/nvim-notify" })
  end,
  config = {
    -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    max_jobs = 32,
    profile = { enable = false, threshold = 1 },
  },
})
