-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(string.format("git clone %s %s",
    "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim"))

  print(out)
  print("Downloading packer.nvim...")

  return
end

local use_coc = true

return require("packer").startup({
  function()
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}

    use {
      "svermeulen/vimpeccable",
      config = function()
        require("core.mappings")
      end,
    }

    -- Git
    use {
      "APZelos/blamer.nvim",
      after = "vimpeccable",
      cmd = {"BlamerToggle", "BlamerShow", "BlamerHide"},
      setup = function()
        require("vimp")
        vim.g.blamer_delay = 250
        vimp.nnoremap({"silent"}, "<leader>gB", ":BlamerToggle<cr>")
      end,
    }
    use "rhysd/git-messenger.vim"
    -- Finders
    use {
      "dyng/ctrlsf.vim",
      config = function()
        require("plugins.ctrlsf")
      end,
    }
    use {
      "nvim-lua/telescope.nvim",
      config = function()
        require("plugins.telescope")
      end,
      requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
    }
    use {"nvim-telescope/telescope-fzy-native.nvim", requires = "nvim-lua/telescope.nvim"}
    use {"nvim-telescope/telescope-github.nvim", requires = "nvim-lua/telescope.nvim"}
    use {"nvim-telescope/telescope-vimspector.nvim", requires = "nvim-lua/telescope.nvim"}
    -- Statusline
    use {
      "datwaft/bubbly.nvim",
      config = function()
        require("plugins.bubbly")
      end,
    }
    -- Notes
    use {
      "oberblastmeister/neuron.nvim",
      after = {"plenary.nvim", "telescope.nvim", "vimpeccable"},
      config = function()
        require("plugins.neuron")
      end,
      requires = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    }
    -- Start screen
    use {
      "mhinz/vim-startify",
      after = "vimpeccable",
      config = function()
        vim.g.startify_session_persistence = 1
        vim.g.startify_update_oldfiles = 1

        vimp.nnoremap({"silent"}, "<leader>H", ":Startify<cr>")
        -- vimp.nnoremap({"silent"}, "<leader>Ss", ":SSave!")
        -- vimp.nnoremap({"silent"}, "<leader>Sl", ":SLoad")
        -- vimp.nnoremap({"silent"}, "<leader>Sc", ":SClose<cr>")
        -- vimp.nnoremap({"silent"}, "<leader>Sd", ":SDelete<cr>")
      end,
    }
    -- LSP
    use {
      "neoclide/coc.nvim",
      after = "vimpeccable",
      config = function()
        require("plugins.coc")
      end,
      run = function()
        vim.fn["coc#util#install"]()
      end,
      disable = not use_coc,
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lsp")
      end,
      disable = use_coc,
    }
    use {
      "glepnir/lspsaga.nvim",
      config = function()
        require("lspsaga").init_lsp_saga()
      end,
      disable = use_coc,
    }
    use {
      "hrsh7th/nvim-compe",
      config = function()
        require("plugins.completion")
      end,
      disable = use_coc,
    }
    -- Documentation
    use {
      "kkoomen/vim-doge",
      config = function()
        vim.g.doge_doc_standard_python = "numpy"
      end,
      run = function()
        vim.fn["doge#install"]()
      end,
    }
    -- Python
    use {
      "python-rope/ropevim",
      after = "vimpeccable",
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

        vimp.nnoremap({"silent"}, "<M-,>", ":RopeCodeAssist<cr>")
        vimp.nnoremap({"silent"}, "<M-.>", ":RopeLuckyAssist<cr>")
        vimp.nnoremap({"silent"}, "<M-cr>", ":RopeAutoImport<cr>")
        vimp.nnoremap({"silent"}, "<M-d>", ":RopeGotoDefinition<cr>")
      end,
      -- ft = "python"
    }
    use "stsewd/sphinx.nvim"
    -- Clojure
    use "clojure-vim/vim-jack-in"
    use {"tpope/vim-fireplace", ft = "clojure", cmd = "FireplaceConnect"}
    -- Lua
    use "bfredl/nvim-luadev"
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter")
      end,
      run = function()
        vim.cmd("TSUpdate")
      end,
    }
    use {
      "nvim-treesitter/nvim-treesitter-refactor",
      requires = "nvim-treesitter/nvim-treesitter",
    }
    use {"nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter"}
    -- Debugger
    use {
      "puremourning/vimspector",
      config = function()
        require("plugins.debugger")
      end,
    }
    use {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup("python")
        require("dap-python").test_runner = "pytest"

        vimp.nnoremap({"silent"}, "<F4>", require("dap").list_breakpoints)
        vimp.nnoremap({"silent"}, "<F5>", require("dap").continue)
        vimp.nnoremap({"silent"}, "<F6>", require("dap").repl.toggle)
        vimp.nnoremap({"silent"}, "<F8>", require("dap").goto_)
        vimp.nnoremap({"silent"}, "<F9>", require("dap").toggle_breakpoint)
        vimp.nnoremap({"silent"}, "<leader><F9>", function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vimp.nnoremap({"silent"}, "<F10>", require("dap").step_over)
        vimp.nnoremap({"silent"}, "<F11>", require("dap").step_into)
        vimp.nnoremap({"silent"}, "<F12>", require("dap").step_out)
      end,
      requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
      disable = true,
    }
    use {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        vim.g.dap_virtual_text = true
      end,
      requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
      run = function()
        vim.cmd("TSUpdate")
      end,
      disable = true,
    }
    -- Testing
    use {
      "janko/vim-test",
      config = function()
        require("plugins.test")
      end,
    }
    -- Code folding
    use "kalekundert/vim-coiled-snake"
    use "Konfekt/FastFold"
    -- Syntax highlighters
    use "LnL7/vim-nix"
    -- Asciidoc
    use "habamax/vim-asciidoctor"
    -- REPL
    use {
      "kassio/neoterm",
      after = "vimpeccable",
      config = function()
        vim.g.neoterm_autoinsert = 1
        vim.g.neoterm_default_mod = "rightbelow vertical"
        vim.g.neoterm_shell = "fish"

        vimp.nnoremap({"silent"}, "<leader>Tt", ":Ttoggle<cr>")
        vimp.nnoremap({"silent"}, "<leader>Tr", ":TREPLSetTerm<cr>")
        vimp.nnoremap({"silent"}, "<leader>Tf", ":TREPLSendFile<cr>")
        vimp.nnoremap({"silent"}, "<leader>Tl", ":TREPLSendLine<cr>")
        vimp.xnoremap({"silent"}, "<leader>Tl", ":TREPLSendSelection<cr>")
        vimp.rbind("nx", "gx", "<Plug>neoterm-repl-send")
      end,
    }
    use {
      "voldikss/vim-floaterm",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>G",
          ":FloatermNew --width=0.9 --height=0.9 --wintype=float --autoclose=2 lazygit<cr>")
      end,
    }
    use {
      "Olical/conjure",
      config = function()
        vim.cmd [[let g:conjure#log#hud#width = 0.42]]
      end,
      ft = {"clojure", "fennel"},
    }
    use {
      "hkupty/iron.nvim",
      after = "vimpeccable",
      config = function()
        require("iron").core.set_config({preferred = {python = "ipython"}})

        vimp.nnoremap({"silent"}, "<leader>it", ":IronRepl python<cr><ESC>")
        vimp.nnoremap({"silent"}, "<leader>if", ":IronFocus python<cr>")
        vimp.nnoremap({"silent"}, "<leader>ir", ":IronRestart<cr>")
        vimp.nnoremap({"silent"}, "<leader>iw", ":IronWatchCurrentFile")
        vimp.nnoremap({"silent"}, "<leader>iu", ":IronUnwatchCurrentFile<cr>")

        vimp.nmap({"silent"}, "<localleader>s", "<Plug>(iron-send-motion)")
        vimp.vmap({"silent"}, "<localleader>s", "<Plug>iron-visual-send")
        vimp.vmap({"silent"}, "<localleader>r", "<Plug>iron-repeat-cmd")
        vimp.vmap({"silent"}, "<localleader>l", "<Plug>(iron-send-line)")
        vimp.vmap({"silent"}, "<localleader><cr>", "<Plug>(iron-cr)")
        vimp.vmap({"silent"}, "<localleader>i", "<Plug>(iron-interrupt)")
        vimp.vmap({"silent"}, "<localleader>q", "<Plug>(iron-exit)")
        vimp.vmap({"silent"}, "<localleader>c", "<Plug>(iron-clear)")
      end,
    }
    use "tpope/vim-markdown"
    -- Color scheme
    use {
      "bluz71/vim-nightfly-guicolors",
      config = function()
        vim.cmd("colorscheme nightfly")
      end,
      disable = true,
    }
    use {
      "bluz71/vim-moonfly-colors",
      config = function()
        vim.cmd("colorscheme moonfly")
      end,
      disable = true,
    }
    use {
      "ChristianChiarulli/nvcode-color-schemes.vim",
      config = function()
        vim.cmd("colorscheme onedark")
      end,
    }
    -- Icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require"nvim-web-devicons".setup {default = true}
      end,
    }
    -- Brackets
    use "adelarsq/vim-matchit" -- Extends % operator
    use {"cohama/lexima.vim", disable = true}
    use {
      "luochen1990/rainbow",
      setup = function()
        vim.g.rainbow_active = 1
      end,
    }
    use "machakann/vim-sandwich"
    -- Marks
    use "inkarkat/vim-mark"
    use "kshenoy/vim-signature"
    -- Indentation
    use {
      "lukas-reineke/indent-blankline.nvim",
      branch = "lua",
      config = function()
        vim.g.indent_blankline_buftype_exclude = {"nofile", "prompt", "terminal"}
        vim.g.indent_blankline_char = "¦"
        vim.g.indent_blankline_filetype_exclude = {"packer", "startify"}
      end,
    }
    use "tpope/vim-sleuth"
    -- Keybinds
    use "tpope/vim-unimpaired"
    -- Movement
    use {
      "easymotion/vim-easymotion",
      config = function()
        require("plugins.easymotion")
      end,
    }
    use "rhysd/clever-f.vim"
    -- Text manipulation
    use {
      "AndrewRadev/switch.vim",
      config = function()
        vim.g.switch_mapping = "-"
      end,
    }
    use {
      "junegunn/vim-easy-align",
      after = "vimpeccable",
      cmd = "EasyAlign",
      setup = function()
        require("vimp")
        -- Start interactive EasyAlign in visual mode (e.g. vipga)
        vimp.xnoremap({"silent"}, "ga", ":EasyAlign<cr>")
        -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
        vimp.nnoremap({"silent"}, "ga", ":EasyAlign<cr>")
      end,
    }
    use {
      "tpope/vim-sexp-mappings-for-regular-people",
      after = "vim-sexp",
      ft = {"clojure", "fennel"},
    }
    use {
      "guns/vim-sexp",
      config = function()
        vim.g.sexp_enable_insert_mode_mappings = 0
      end,
      ft = {"clojure", "fennel"},
    }
    use "matze/vim-move"
    use {
      "machakann/vim-swap",
      after = "vimpeccable",
      config = function()
        vimp.rbind("ox", "i,", "<Plug>(swap-textobject-i)")
        vimp.rbind("ox", "a,", "<Plug>(swap-textobject-a)")
      end,
    }
    use "mg979/vim-visual-multi"
    use {
      "nicwest/vim-camelsnek",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
        vimp.xnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
        vimp.nnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
        vimp.xnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
        vimp.nnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
        vimp.xnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
        vimp.nnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
        vimp.xnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
      end,
    }
    use "tpope/vim-repeat"
    -- Increment / Decrement
    use {
      "monaqa/dial.nvim",
      config = function()
        vimp.nmap({"silent"}, "<C-a>", "<Plug>(dial-increment)")
        vimp.xmap({"silent"}, "<C-a>", "<Plug>(dial-increment)")
        vimp.nmap({"silent"}, "<C-x>", "<Plug>(dial-decrement)")
        vimp.xmap({"silent"}, "<C-x>", "<Plug>(dial-decrement)")
        vimp.nmap({"silent"}, "g<C-a>", "<Plug>(dial-increment-additional)")
        vimp.nmap({"silent"}, "g<C-x>", "<Plug>(dial-decrement-additional)")
      end,
    }
    -- Comments
    use "tomtom/tcomment_vim"
    use {
      "terrortylor/nvim-comment",
      config = function()
        require("nvim_comment").setup()
      end,
      disable = true,
    }
    -- Text substitution
    use {
      "svermeulen/vim-subversive",
      after = "vimpeccable",
      config = function()
        vim.cmd [[nmap s <Plug>(SubversiveSubstitute)]]
        vim.cmd [[nmap ss <Plug>(SubversiveSubstituteLine)]]
        vim.cmd [[nmap sl <Plug>(SubversiveSubstituteToEndOfLine)]]

        vim.cmd [[xmap s <Plug>(SubversiveSubstitute)]]
        vim.cmd [[xmap p <Plug>(SubversiveSubstitute)]]
        vim.cmd [[xmap P <Plug>(SubversiveSubstitute)]]

        vim.cmd [[nmap <leader><leader>s <Plug>(SubversiveSubvertRange)]]
        vim.cmd [[xmap <leader><leader>s <Plug>(SubversiveSubvertRange)]]
        vim.cmd [[nmap <leader><leader>ss <Plug>(SubversiveSubvertWordRange)]]

        vim.cmd [[nmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]]
        vim.cmd [[xmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]]
        vim.cmd [[nmap <leader>css <Plug>(SubversiveSubstituteWordRangeConfirm)]]

        -- ie = inner entire buffer
        vimp.onoremap({"silent"}, "ie", [[:exec "normal! ggVG"<cr>]])
        -- iv = current viewable text in the buffer
        vimp.onoremap({"silent"}, "iv", [[:exec "normal! HVL"<cr>]])
      end,
    }
    use "tpope/vim-abolish"
    -- Text splitting
    use "AndrewRadev/splitjoin.vim"
    use {"sk1418/Join", cmd = "Join"}
    -- Text objects
    use {
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
    }
    use "glts/vim-textobj-comment"
    use "julian/vim-textobj-variable-segment"
    use "kana/vim-textobj-user"
    use "michaeljsmith/vim-indent-object"
    use "wellle/targets.vim"
    -- Buffers
    use "moll/vim-bbye"
    use {
      "wfxr/minimap.vim",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>C", ":MinimapToggle<cr>")
      end,
    }
    -- Tabs
    use "caenrique/nvim-maximize-window-toggle"
    use "gcmt/taboo.vim"
    -- Tmux
    use {"christoomey/vim-tmux-navigator"}
    -- File explorer
    use {
      "ms-jpq/chadtree",
      config = function()
        require("plugins.chadtree")
      end,
      run = "python3 -m chadtree deps",
    }
    -- Projects
    use {
      "tpope/vim-projectionist",
      config = function()
        vim.g.projectionist_heuristics = {
          ["data_catalog/*.py"] = {["alternate"] = "tests/unit/test_{}.py"},
        }

        -- vimp.nnoremap({"silent"}, "go", ":A<cr>")
      end,
    }
    -- Search
    use {
      "brooth/far.vim",
      config = function()
        require("plugins.far")
      end,
    }
    use {
      "windwp/nvim-spectre",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>S", require("spectre").open)
        vimp.vnoremap({"silent"}, "<leader>S", require("spectre").open_visual)
        require("spectre").setup({
          mapping = {
            ["delete_line"] = {
              map = "dd",
              cmd = "<cmd>lua require('spectre').delete()<CR>",
              desc = "delete current item",
            },
            ["enter_file"] = {
              map = "<cr>",
              cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
              desc = "goto current file",
            },
            ["send_to_qf"] = {
              map = "rq",
              cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
              desc = "send all item to quickfix",
            },
            ["replace_cmd"] = {
              map = "rc",
              cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
              desc = "input replace vim command",
            },
            ["show_option_menu"] = {
              map = "to",
              cmd = "<cmd>lua require('spectre').show_options()<CR>",
              desc = "show option",
            },
            ["run_replace"] = {
              map = "rS",
              cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
              desc = "replace all",
            },
            ["toggle_ignore_case"] = {
              map = "ti",
              cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
              desc = "toggle ignore case",
            },
            ["toggle_ignore_hidden"] = {
              map = "th",
              cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
              desc = "toggle search hidden",
            },
          },
        })
      end,
    }
    use {"inkarkat/vim-SearchAlternatives", requires = "inkarkat/vim-ingo-library"}
    use "romainl/vim-cool"
    -- use 'pgdouyon/vim-evanesco'
    -- use {
    --   "gabrielpoca/replacer.nvim",
    --   config = function()
    --     vimp.nnoremap({"silent"}, "<leader>R", require("replacer").run())
    --   end,
    -- }
    -- Discover keybinds
    use {
      "liuchengxu/vim-which-key",
      cmd = {"WhichKey"},
      setup = function()
        vim.api.nvim_set_keymap("n", "<leader>", ":WhichKey '<leader>'<cr>",
          {noremap = true, silent = true})
      end,
    }
    -- Save position
    use "farmergreg/vim-lastplace"
    -- Dispatcher
    use {
      "skywind3000/asynctasks.vim",
      cmd = {
        "AsyncTask",
        "AsyncTaskEdit",
        "AsyncTaskList",
        "AsyncTaskMacro",
        "AsyncTaskProfile",
      },
      requires = {
        "skywind3000/asyncrun.vim",
        setup = function()
          vim.g.asyncrun_open = 12
        end,
      },
    }
    use {"tpope/vim-dispatch", cmd = {"Dispatch", "Make", "Focus", "Start"}}
    -- Root directory
    use {
      "airblade/vim-rooter",
      config = function()
        vim.g.rooter_silent_chdir = 0
        vim.g.rooter_patterns = {".git", ".root"}
      end,
    }
    -- Autosave
    use {
      "907th/vim-auto-save",
      setup = function()
        vim.g.auto_save = 0
        vim.g.auto_save_silent = 1
        vim.g.auto_save_events = {"InsertLeave", "FocusLost"}
      end,
    }
    -- Filetypes
    use "isobit/vim-caddyfile"
    use "~/dev/neovim/pytest.nvim"
  end,
  config = {max_jobs = 32},
})
