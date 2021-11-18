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

    use({
      "svermeulen/vimpeccable",
      config = function()
        require("core.mappings")
      end,
    })
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>gB", "<cmd>GitBlameToggle<CR>")
      end,
    })
    use({
      "rhysd/git-messenger.vim",
      cmd = "GitMessenger",
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>m", "<cmd>GitMessenger<CR>")
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
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--ignore-case",
            },
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

        vimp.nnoremap({ "silent" }, "<leader>fg", function()
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
        require("vimp")

        vimp.nnoremap({ "override", "silent" }, "<leader>ff", "<cmd>Telescope find_files<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fr", "<cmd>Telescope resume<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fl", "<cmd>Telescope live_grep<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fL", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fb", "<cmd>Telescope buffers<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fh", "<cmd>Telescope oldfiles<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fm", "<cmd>Telescope marks<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fc", "<cmd>Telescope git_bcommits<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fv", "<cmd>Telescope git_status<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fk", "<cmd>Telescope keymaps<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fs", "<cmd>Telescope symbols<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fo", "<cmd>Telescope project<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>O", "<cmd>Telescope spell_suggest<CR>")

        vimp.nnoremap({ "override", "silent" }, "<leader>dc", "<cmd>Telescope dap commands<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>db", "<cmd>Telescope dap list_breakpoints<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>df", "<cmd>Telescope dap frames<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>dv", "<cmd>Telescope dap variables<CR>")

        vimp.nnoremap({ "override", "silent" }, "<leader>fi", "<cmd>Telescope gh issues<CR>")
        vimp.nnoremap({ "override", "silent" }, "<leader>fp", "<cmd>Telescope gh pull_request<CR>")

        vimp.nnoremap({ "override", "silent" }, "<leader>y", "<cmd>Telescope neoclip<CR>")

        vimp.nnoremap({ "override", "silent" }, "gd", "<cmd>Telescope lsp_definitions<CR>")
        vimp.nnoremap({ "override", "silent" }, "gr", "<cmd>Telescope lsp_references<CR>")
        vimp.nnoremap({ "override", "silent" }, "gy", "<cmd>Telescope lsp_implementations<CR>")
        vimp.nnoremap({ "override", "silent" }, "<Space>a", "<cmd>Telescope lsp_code_actions<CR>")
        vimp.xnoremap({ "override", "silent" }, "<Space>a", "<cmd>Telescope lsp_range_code_actions<CR>")
        vimp.nnoremap({ "override", "silent" }, "<Space>o", "<cmd>Telescope lsp_document_symbols<CR>")
        vimp.nnoremap({ "override", "silent" }, "<Space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
        vimp.nnoremap({ "override", "silent" }, "<Space>e", "<cmd>Telescope lsp_document_diagnostics<CR>")
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>ft", "<cmd>TodoTelescope<cr>")
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
                workspaces = {
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
        local luasnip = require("luasnip")
        local cmp = require("cmp")

        cmp.setup({
          formatting = {
            format = function(entry, vim_item)
              vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
              vim_item.menu = ({
                fuzzy_buffer = "[Buf]",
                luasnip = "[Snip]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                orgmode = "[Org]",
                path = "[Path]",
              })[entry.source.name]
              return vim_item
            end,
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
      "ldelossa/calltree.nvim",
      config = function()
        require("calltree").setup({ layout_size = 40, icons = "codicon" })
      end,
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
        vimp.nnoremap({ "override", "silent" }, "<leader>j", require("neogen").generate)
      end,
    })
    use({ "nanotee/sqls.nvim", ft = "sql" })
    -- Python
    use({ "stsewd/sphinx.nvim", ft = { "python", "rst" } })
    use({
      "dccsillag/magma-nvim",
      cmd = { "MagmaInit" },
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<localleader>ri", ":MagmaInit<CR>")
        -- vimp.nnoremap({ "override", "expr", "silent" }, "<localleader>r", "nvim_exec('MagmaEvaluateOperator', v:true)")
        vimp.xnoremap({ "override", "silent" }, "<localleader>r", ":<C-u>MagmaEvaluateVisual<CR>")
        vimp.nnoremap({ "override", "silent" }, "<localleader>rl", ":MagmaEvaluateLine<CR>")
        vimp.nnoremap({ "override", "silent" }, "<localleader>rc", ":MagmaReevaluateCell<CR>")
        vimp.nnoremap({ "override", "silent" }, "<localleader>rd", ":MagmaDelete<CR>")
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
        require("refactoring").setup()

        -- telescope refactoring helper
        local function refactor(prompt_bufnr)
          local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          require("telescope.actions").close(prompt_bufnr)
          require("refactoring").refactor(content.value)
        end

        local function refactors()
          local opts = require("telescope.themes").get_cursor() -- set personal telescope options
          require("telescope.pickers").new(opts, {
            prompt_title = "refactors",
            finder = require("telescope.finders").new_table({
              results = require("refactoring").get_refactors(),
            }),
            sorter = require("telescope.config").values.generic_sorter(opts),
            attach_mappings = function(_, map)
              map("i", "<CR>", refactor)
              map("n", "<CR>", refactor)
              return true
            end,
          }):find()
        end

        vimp.vnoremap({ "override", "silent" }, "<leader>re", function()
          require("refactoring").refactor("Extract Function")
        end)
        vimp.vnoremap({ "override", "silent" }, "<leader>rf", function()
          require("refactoring").refactor("Extract Function To File")
        end)
        vimp.vnoremap({ "override", "silent" }, "<leader>rt", refactors)
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

        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<F2>", require("dap").repl.toggle)
        vimp.nnoremap({ "override", "silent" }, "<F3>", require("dap").stop)
        vimp.nnoremap({ "override", "silent" }, "<F5>", require("dap").continue)
        vimp.nnoremap({ "override", "silent" }, "<F6>", require("dap").run_to_cursor)
        vimp.nnoremap({ "override", "silent" }, "<F7>", require("dap").up)
        vimp.nnoremap({ "override", "silent" }, "<F8>", require("dap").down)
        vimp.nnoremap({ "override", "silent" }, "<F9>", require("dap").toggle_breakpoint)
        vimp.nnoremap({ "override", "silent" }, "<leader><F9>", function()
          require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vimp.nnoremap({ "override", "silent" }, "<localleader><F9>", function()
          require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end)
        vimp.nnoremap({ "override", "silent" }, "<F10>", require("dap").step_over)
        vimp.nnoremap({ "override", "silent" }, "<F11>", require("dap").step_into)
        vimp.nnoremap({ "override", "silent" }, "<F12>", require("dap").step_out)
        vimp.nnoremap({ "override", "silent" }, "<leader>dh", require("dap.ui.widgets").hover)
      end,
      filetype = { "go", "python", "rust", "typescript" },
    })
    use({
      "rcarriga/nvim-dap-ui",
      after = "nvim-dap",
      config = function()
        require("dapui").setup()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>du", require("dapui").toggle)
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>tt", ":Ultest<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>tn", ":UltestNearest<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>ts", ":UltestSummary<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>td", ":UltestDebug<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>tD", ":UltestDebugNearest<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>to", ":UltestOutput<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>tc", ":UltestClear<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>tj", "<Plug>(ultest-output-jump)")
        vimp.nmap({ "override", "silent" }, "]t", "<Plug>(ultest-next-fail)")
        vimp.nmap({ "override", "silent" }, "[t", "<Plug>(ultest-prev-fail)")
      end,
      run = ":UpdateRemotePlugins",
    })
    use({
      "janko/vim-test",
      config = function()
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
      after = "vimpeccable",
      cmd = { "T", "Texec", "Tmap", "Tnew", "Topen", "Ttoggle" },
      config = function()
        vim.g.neoterm_autoinsert = 1
        vim.g.neoterm_default_mod = "rightbelow vertical"
        vim.g.neoterm_shell = "fish"
      end,
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>Tt", ":Ttoggle<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>Tr", ":TREPLSetTerm<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>Tf", ":TREPLSendFile<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>Tl", ":TREPLSendLine<cr>")
        vimp.xnoremap({ "override", "silent" }, "<leader>Tl", ":TREPLSendSelection<cr>")
        vimp.rbind("nx", { "override" }, "gx", "<Plug>neoterm-repl-send")
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

        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>G", function()
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
    use({ "andymass/vim-matchup" })
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
        require("lightspeed").setup({})
      end,
    })
    use({
      "mfussenegger/nvim-ts-hint-textobject",
      after = "nvim-treesitter",
      config = function()
        require("vimp")
        vimp.omap({ "override", "silent" }, "m", ":<C-U>lua require('tsht').nodes()<CR>")
        vimp.vnoremap({ "override", "silent" }, "m", ":lua require('tsht').nodes()<CR>")
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
      after = "vimpeccable",
      cmd = "EasyAlign",
      setup = function()
        require("vimp")
        -- Start interactive EasyAlign in visual mode (e.g. vipga)
        vimp.xnoremap({ "override", "silent" }, "ga", ":EasyAlign<cr>")
        -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
        vimp.nnoremap({ "override", "silent" }, "ga", ":EasyAlign<cr>")
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
      after = "vimpeccable",
      cmd = { "Camel", "CamelB", "Kebab", "Snek" },
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>xs", ":Snek<cr>")
        vimp.xnoremap({ "override", "silent" }, "<leader>xs", ":Snek<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>xc", ":Camel<cr>")
        vimp.xnoremap({ "override", "silent" }, "<leader>xc", ":Camel<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>xb", ":CamelB<cr>")
        vimp.xnoremap({ "override", "silent" }, "<leader>xb", ":CamelB<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>xk", ":Kebab<cr>")
        vimp.xnoremap({ "override", "silent" }, "<leader>xk", ":Kebab<cr>")
      end,
    })
    use({ "tpope/vim-repeat", keys = "." })
    -- Increment / Decrement
    use({
      "monaqa/dial.nvim",
      setup = function()
        require("vimp")
        vimp.nmap({ "override", "silent" }, "<C-a>", "<Plug>(dial-increment)")
        vimp.xmap({ "override", "silent" }, "<C-a>", "<Plug>(dial-increment)")
        vimp.nmap({ "override", "silent" }, "<C-x>", "<Plug>(dial-decrement)")
        vimp.xmap({ "override", "silent" }, "<C-x>", "<Plug>(dial-decrement)")
        vimp.nmap({ "override", "silent" }, "g<C-a>", "<Plug>(dial-increment-additional)")
        vimp.nmap({ "override", "silent" }, "g<C-x>", "<Plug>(dial-decrement-additional)")
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
      after = "vimpeccable",
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
        vimp.onoremap({ "override", "silent" }, "ie", [[:exec "normal! ggVG"<cr>]])
        -- iv = current viewable text in the buffer
        vimp.onoremap({ "override", "silent" }, "iv", [[:exec "normal! HVL"<cr>]])
      end,
    })
    -- Text objects
    use("wellle/targets.vim")
    -- Buffers
    use({ "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } })
    use({
      "wfxr/minimap.vim",
      after = "vimpeccable",
      cmd = "MinimapToggle",
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>C", "<cmd>MinimapToggle<CR>")
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>z", "<cmd>ZenMode<CR>")
      end,
    })
    -- Tabs
    use("gcmt/taboo.vim")
    -- Tmux
    use({
      "numToStr/Navigator.nvim",
      config = function()
        require("Navigator").setup()

        vimp.nnoremap({ "override", "silent" }, "<C-h>", require("Navigator").left)
        vimp.nnoremap({ "override", "silent" }, "<C-j>", require("Navigator").down)
        vimp.nnoremap({ "override", "silent" }, "<C-k>", require("Navigator").up)
        vimp.nnoremap({ "override", "silent" }, "<C-l>", require("Navigator").right)
        vimp.nnoremap({ "override", "silent" }, "<C-p>", require("Navigator").previous)
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

        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>e", ":NvimTreeToggle<CR>")
      end,
    })
    -- Projects
    use({
      "tpope/vim-projectionist",
      config = function()
        vim.g.projectionist_heuristics = {
          ["data_catalog/*.py"] = { ["alternate"] = "tests/unit/test_{}.py" },
        }
        -- vimp.nnoremap({"override", "silent"}, "go", ":A<cr>")
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>S", ":lua require('spectre').open()<CR>")
        vimp.vnoremap({ "override", "silent" }, "<leader>S", ":lua require('spectre').open_visual()<CR>")
        vimp.nnoremap({ "override", "silent" }, "<localleader>S", ":lua require('spectre').open_file_search()<CR>")
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
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "*", require("starlite").star)
        vimp.vnoremap({ "override", "silent" }, "g*", require("starlite").g_star)
        vimp.nnoremap({ "override", "silent" }, "#", require("starlite").hash)
        vimp.nnoremap({ "override", "silent" }, "g#", require("starlite").g_hash)
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
