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

    -- Utility
    use({
      "nvim-lua/plenary.nvim",
      module = "plenary",
    })
    use({
      "nvim-lua/popup.nvim",
      module = "popup",
    })
    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugins.git")
      end,
      event = { "BufRead", "BufNewFile" },
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
    use({
      "sindrets/diffview.nvim",
      cmd = "DiffviewOpen",
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>u", "<cmd>DiffviewOpen<CR>")
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
      keys = { "<leader>nf", "<leader>nF", "<leader>nn" },
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
            -- prompt_position = "top",
            -- sorting_strategy = "ascending",  -- breaks Telescope
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

        vimp.nnoremap({ "silent" }, "<leader>ff", "<cmd>Telescope find_files<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fr", "<cmd>Telescope live_grep<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fb", "<cmd>Telescope buffers<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fh", "<cmd>Telescope oldfiles<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fm", "<cmd>Telescope marks<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fc", "<cmd>Telescope git_bcommits<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fv", "<cmd>Telescope git_status<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fk", "<cmd>Telescope keymaps<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fs", "<cmd>Telescope symbols<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fo", "<cmd>Telescope project<CR>")
        vimp.nnoremap({ "silent" }, "<leader>O", "<cmd>Telescope spell_suggest<CR>")

        vimp.nnoremap({ "silent" }, "<leader>db", "<cmd>Telescope dap list_breakpoints<CR>")
        vimp.nnoremap({ "silent" }, "<leader>df", "<cmd>Telescope dap frames<CR>")

        vimp.nnoremap({ "silent" }, "<leader>fi", "<cmd>Telescope gh issues<CR>")
        vimp.nnoremap({ "silent" }, "<leader>fp", "<cmd>Telescope gh pull_request<CR>")

        vimp.nnoremap({ "silent" }, "gd", "<cmd>Telescope lsp_definitions<CR>")
        vimp.nnoremap({ "silent" }, "gr", "<cmd>Telescope lsp_references<CR>")
        vimp.nnoremap({ "silent" }, "gy", "<cmd>Telescope lsp_implementations<CR>")
        vimp.nnoremap({ "silent" }, "<space>o", "<cmd>Telescope lsp_document_symbols<CR>")
        vimp.nnoremap({ "silent" }, "<space>s", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
        vimp.nnoremap({ "silent" }, "<space>e", "<cmd>Telescope lsp_document_diagnostics<CR>")
      end,
      requires = {
        { "nvim-telescope/telescope-dap.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", opt = true, run = "make" },
        { "nvim-telescope/telescope-github.nvim", opt = true },
        { "nvim-telescope/telescope-project.nvim", opt = true },
        { "nvim-telescope/telescope-symbols.nvim", opt = true },
      },
    })
    -- Todo
    use({
      "folke/todo-comments.nvim",
      cmd = { "TodoTrouble", "TodoTelescope" },
      config = function()
        require("todo-comments").setup({})
      end,
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<space>tc", "<cmd>TodoTrouble<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>ft", "<cmd>TodoTelescope<cr>")
      end,
    })
    -- Statusline
    use({
      "datwaft/bubbly.nvim",
      config = function()
        require("plugins.bubbly")
      end,
      disable = false,
    })
    use({
      "glepnir/galaxyline.nvim",
      config = function()
        require("plugins.galaxyline")
      end,
      disable = true,
      event = "BufEnter",
    })
    -- Notes
    use({
      "kristijanhusak/orgmode.nvim",
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/doc/org/*" },
          org_default_notes_file = "~/doc/org/refile.org",
        })
      end,
    })
    use({
      "oberblastmeister/neuron.nvim",
      after = { "plenary.nvim", "telescope.nvim", "vimpeccable" },
      config = function()
        require("neuron").setup({
          virtual_titles = true,
          mappings = true,
          run = nil, -- function to run when in neuron dir
          neuron_dir = "~/doc/zettelkasten", -- the directory of all of your notes
          leader = "<leader>n",
        })

        require("vimp")
        -- create a new note
        vimp.nnoremap("<leader>nn", function()
          require("neuron/cmd").new_edit(require("neuron").config.neuron_dir)
        end)
        -- find your notes, click enter to create the note if there are not notes that match
        vimp.nnoremap("<leader>nf", require("neuron/telescope").find_zettels)
        -- insert the id of the note that is found
        vimp.nnoremap("<leader>nF", function()
          require("neuron/telescope").find_zettels({ insert = true })
        end)
      end,
      requires = { "nvim-telescope/telescope.nvim" },
    })
    -- Start screen
    use({
      "mhinz/vim-startify",
      after = "vimpeccable",
      config = function()
        vim.g.startify_session_persistence = 1
        vim.g.startify_update_oldfiles = 1

        vimp.nnoremap({ "override", "silent" }, "<leader>H", ":Startify<cr>")
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
      "glepnir/lspsaga.nvim",
      cmd = "Lspsaga",
      config = function()
        require("lspsaga").init_lsp_saga({ use_saga_diagnostic_sign = false })
      end,
    })
    use({
      "onsails/lspkind-nvim",
      config = function()
        require("lspkind").init()
      end,
      event = "InsertEnter",
    })
    use({
      "hrsh7th/nvim-compe",
      config = function()
        require("plugins.completion")
      end,
      event = "InsertEnter",
    })
    use({
      "folke/trouble.nvim",
      cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
      config = function()
        require("trouble").setup({})
      end,
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<space>tt", "<cmd>TroubleToggle<cr>")
        vimp.nnoremap({ "override", "silent" }, "<space>tw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
        vimp.nnoremap({ "override", "silent" }, "<space>td", "<cmd>TroubleToggle lsp_document_diagnostics<cr>")
        vimp.nnoremap({ "override", "silent" }, "<space>tl", "<cmd>TroubleToggle loclist<cr>")
        vimp.nnoremap({ "override", "silent" }, "<space>tq", "<cmd>TroubleToggle quickfix<cr>")
        vimp.nnoremap({ "override", "silent" }, "gR", "<cmd>Trouble lsp_references<cr>")
      end,
    })
    use({
      "ray-x/lsp_signature.nvim",
      config = function()
        require("lsp_signature").on_attach({
          hint_enable = false,
          handler_opts = { border = "none" },
        })
      end,
      event = "InsertEnter",
    })
    -- Documentation
    use({
      "kkoomen/vim-doge",
      cmd = { "DogeGenerate", "DogeCreateDocStandard" },
      config = function()
        vim.g.doge_doc_standard_python = "numpy"
      end,
      run = function()
        vim.fn["doge#install"]()
      end,
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>j", "<cmd>DogeGenerate<CR>")
      end,
    })
    -- SQL
    use({ "nanotee/sqls.nvim", ft = "sql" })
    -- Python
    use({
      "python-rope/ropevim",
      after = "vimpeccable",
      cmd = {
        "RopeCodeAssist",
        "RopeLuckyAssist",
        "RopeAutoImport",
        "RopeGotoDefinition",
        "RopeGenerateAutoimportCache",
      },
      config = function()
        vim.g.ropevim_local_prefix = "<M-r>"
        vim.g.ropevim_global_prefix = "<M-p>"
        vim.g.ropevim_autoimport_modules = {
          "abc",
          "contextlib",
          "datetime",
          "functools",
          "itertools",
          "json",
          "kartothek",
          "logging",
          "numpy",
          "os",
          "pandas",
          "pytest",
          "requests",
          "subprocess",
          "tenacity",
          "typing",
          "uuid",
        }
        vim.g.ropevim_enable_autoimport = 1
        vim.g.ropevim_guess_project = 1

        vimp.nnoremap({ "override", "silent" }, "<M-,>", ":RopeCodeAssist<cr>")
        vimp.nnoremap({ "override", "silent" }, "<M-.>", ":RopeLuckyAssist<cr>")
        vimp.nnoremap({ "override", "silent" }, "<M-cr>", ":RopeAutoImport<cr>")
        vimp.nnoremap({ "override", "silent" }, "<M-d>", ":RopeGotoDefinition<cr>")
      end,
    })
    use({ "stsewd/sphinx.nvim", ft = { "python", "rst" } })
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
      ft = { "python" },
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
    })
    -- Testing
    use({
      "rcarriga/vim-ultest",
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
      ft = "python",
      setup = function()
        require("vimp")
        vimp.nnoremap({ "silent" }, "<leader>tt", ":Ultest<cr>")
        vimp.nnoremap({ "silent" }, "<leader>tn", ":UltestNearest<CR>")
        vimp.nnoremap({ "silent" }, "<leader>ts", ":UltestSummary<cr>")
        vimp.nnoremap({ "silent" }, "<leader>td", ":UltestDebug<cr>")
        vimp.nnoremap({ "silent" }, "<leader>tD", ":UltestDebugNearest<cr>")
        vimp.nnoremap({ "silent" }, "<leader>to", ":UltestOutput<cr>")
        vimp.nnoremap({ "silent" }, "<leader>tc", ":UltestClear<cr>")
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
      ft = "python",
    })
    -- Code folding
    use({ "kalekundert/vim-coiled-snake", ft = "python" })
    use({ "Konfekt/FastFold", event = "BufRead" })
    -- Syntax highlighters
    use({ "LnL7/vim-nix", ft = "nix" })
    use({ "RRethy/vim-illuminate", event = "BufRead" })
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
        require("FTerm").setup()
      end,
    })
    use({
      "voldikss/vim-floaterm",
      cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
      setup = function()
        require("vimp")
        vimp.nnoremap(
          { "override", "silent" },
          "<leader>G",
          ":FloatermNew --width=0.9 --height=0.9 --wintype=float --autoclose=2 lazygit<cr>"
        )
      end,
    })
    use({
      "Olical/conjure",
      config = function()
        vim.cmd([[let g:conjure#log#hud#width = 0.42]])
        vim.g.compe.source.conjure = true
      end,
      ft = { "clojure", "fennel" },
    })
    use({
      "hkupty/iron.nvim",
      after = "vimpeccable",
      cmd = {
        "IronRepl",
        "IronFocus",
        "IronRestart",
        "IronWatchCurrentFile",
        "IronUnwatchCurrentFile",
      },
      config = function()
        require("iron").core.set_config({ preferred = { python = "ipython" } })
      end,
      setup = function()
        require("vimp")
        vimp.nnoremap({ "override", "silent" }, "<leader>it", ":IronRepl python<cr><ESC>")
        vimp.nnoremap({ "override", "silent" }, "<leader>if", ":IronFocus python<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>ir", ":IronRestart<cr>")
        vimp.nnoremap({ "override", "silent" }, "<leader>iw", ":IronWatchCurrentFile")
        vimp.nnoremap({ "override", "silent" }, "<leader>iu", ":IronUnwatchCurrentFile<cr>")

        vimp.nmap({ "override", "silent" }, "<localleader>s", "<Plug>(iron-send-motion)")
        vimp.vmap({ "override", "silent" }, "<localleader>s", "<Plug>iron-visual-send")
        vimp.vmap({ "override", "silent" }, "<localleader>r", "<Plug>iron-repeat-cmd")
        vimp.vmap({ "override", "silent" }, "<localleader>l", "<Plug>(iron-send-line)")
        vimp.vmap({ "override", "silent" }, "<localleader><cr>", "<Plug>(iron-cr)")
        vimp.vmap({ "override", "silent" }, "<localleader>i", "<Plug>(iron-interrupt)")
        vimp.vmap({ "override", "silent" }, "<localleader>q", "<Plug>(iron-exit)")
        vimp.vmap({ "override", "silent" }, "<localleader>c", "<Plug>(iron-clear)")
      end,
    })
    -- Color scheme
    use({ "folke/lsp-colors.nvim", event = "BufRead" })
    use({
      "bluz71/vim-nightfly-guicolors",
      config = function()
        vim.cmd("colorscheme nightfly")
      end,
      disable = true,
    })
    use({
      "bluz71/vim-moonfly-colors",
      config = function()
        vim.cmd("colorscheme moonfly")
      end,
      disable = true,
    })
    use({
      "ChristianChiarulli/nvcode-color-schemes.vim",
      config = function()
        vim.cmd("colorscheme onedark")
      end,
    })
    use({
      "folke/tokyonight.nvim",
      config = function()
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_sidebars = { "NvimTree", "packer", "qf", "terminal" }
        vim.cmd("colorscheme tokyonight")
      end,
      disable = true,
    })
    -- Icons
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup({ default = true })
      end,
    })
    -- Extend % operator
    use({ "andymass/vim-matchup", keys = { "%", "g%", "[%", "]%", "z%" } })
    -- Brackets
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
      event = "InsertEnter",
    })
    use({
      "blackCauldron7/surround.nvim",
      config = function()
        require("surround").setup({ prefix = "r" })
      end,
      event = "BufRead",
    })
    -- Marks
    use({ "kshenoy/vim-signature", event = "BufRead" })
    -- Indentation
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.g.indent_blankline_buftype_exclude = { "nofile", "prompt", "terminal" }
        vim.g.indent_blankline_char = "¦"
        vim.g.indent_blankline_filetype_exclude = { "packer", "startify" }
      end,
      event = "BufRead",
    })
    use({ "tpope/vim-sleuth", event = "BufRead" })
    -- Keybinds
    use({ "tpope/vim-unimpaired", event = "BufRead" })
    -- Movement
    use({
      "ggandor/lightspeed.nvim",
      config = function()
        require("lightspeed").setup({})
      end,
      keys = { "s", "S", "f", "F", "t", "T" },
    })
    -- Text manipulation
    use({
      "AndrewRadev/switch.vim",
      setup = function()
        vim.g.switch_mapping = "-"
      end,
      event = "BufRead",
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
    use({ "matze/vim-move", event = "BufRead" })
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
      "terrortylor/nvim-comment",
      config = function()
        require("nvim_comment").setup()
      end,
      event = "BufRead",
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
    -- Text splitting
    use({ "AndrewRadev/splitjoin.vim", event = "BufRead" })
    use({ "sk1418/Join", cmd = "Join" })
    -- Text objects
    use({
      "chaoren/vim-wordmotion",
      config = function()
        vim.g.wordmotion_mappings = {
          ["w"] = "<M-w>",
          ["b"] = "<M-b>",
          ["e"] = "<M-e>",
          ["ge"] = "g<M-e>",
          ["aw"] = "a<M-w>",
          ["iw"] = "i<M-w>",
          ["<C-R><C-W>"] = "<C-R><M-w>",
        }
      end,
    })
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
      end,
      disable = true,
    })
    -- File explorer
    use({
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle" },
      config = function()
        vim.g.nvim_tree_ignore = {
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
        }
        vim.g.nvim_tree_auto_close = 1
        vim.g.nvim_tree_follow = 1
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_highlight_opened_files = 1
        vim.g.nvim_tree_group_empty = 1
        vim.g.nvim_tree_lsp_diagnostics = 1
        vim.g.nvim_tree_bindings = {
          { key = { "<CR>", "l", "<2-LeftMouse>" }, cb = require("nvim-tree.config").nvim_tree_callback("edit") },
        }
      end,
      setup = function()
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
      "brooth/far.vim",
      after = "vimpeccable",
      cmd = { "Far", "Farr", "Farp" },
      setup = function()
        require("plugins.far")
      end,
    })
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
    use({ "romainl/vim-cool", event = "BufRead" })
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
      "airblade/vim-rooter",
      config = function()
        vim.g.rooter_silent_chdir = 0
        vim.g.rooter_patterns = { ".git", ".root" }
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
    use("~/dev/neovim/pytest.nvim")
  end,
  config = { max_jobs = 32, profile = { enable = false, threshold = 1 } },
})
