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
      config = function()
        vim.g.blamer_delay = 250
        vimp.nnoremap({"silent"}, "<leader>gB", ":BlamerToggle<cr>")
      end,
    }
    use "jreybert/vimagit"
    use {
      "mhinz/vim-signify",
      config = function()
        require("plugins.signify")
      end,
    }
    use {
      "tpope/vim-fugitive",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>gg", ":Git<cr>")
        vimp.nnoremap({"silent"}, "<leader>gb", ":Git blame<cr>")
        vimp.nnoremap({"silent"}, "<leader>gc", ":Git commit<cr>")
        vimp.nnoremap({"silent"}, "<leader>gd", ":Git diff<cr>")
        vimp.nnoremap({"silent"}, "<leader>gl", ":Git log<cr>")
        vimp.nnoremap({"silent"}, "<leader>gi", ":Gdiffsplit<cr>")
      end,
    }
    -- use "lambdalisue/gina.vim"
    use {
      "rbong/vim-flog",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>gt", ":Flog<CR>")
      end,
    }
    use "rhysd/git-messenger.vim"
    -- Github
    use "mattn/vim-gist"
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
    use {
      "junegunn/fzf.vim",
      config = function()
        vim.api.nvim_exec([[
                            function! g:FzfFilesSource()
                                let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'
                                return printf("fd --type=file --hidden --follow --color=always --exclude=.git | %s %s", l:proximity_sort_path, expand('%'))
                            endfunction

                            let g:fzf_tags_command = 'ctags -R'

                            nmap <silent> <leader>ff :call fzf#vim#files('', {'source': g:FzfFilesSource(), 'options': ['--ansi', '--tiebreak=index', '--layout=reverse', '--info=inline', '--preview', 'bat --color=always --style=numbers {}']})<CR>
                            nmap <leader>fb  :Buffers<CR>
                            nmap <leader>fgc :Commits<CR>
                            nmap <leader>fgf :GFiles<CR>
                            nmap <leader>fgs :GFiles?<CR>
                            nmap <leader>fl  :Lines<CR>
                            nmap <leader>f/  :Rg<CR>
                            nmap <leader>fm  :Marks<CR>
                            nmap <leader>ft  :Tags<CR>
                            nmap <leader>fbt :BTags<CR>
                            nmap <leader>fc  :History:<CR>
                            nmap <leader>fs  :History/<CR>
                            nmap <leader>fh  :History<CR>
                            nmap <leader>fw  :Windows<CR>
                            nmap <leader>fp  :Filetypes<CR>
                            " Insert mode completion
                            imap <c-x><c-k> <plug>(fzf-complete-word)
                            imap <c-x><c-f> <plug>(fzf-complete-path)
                            imap <c-x><c-j> <plug>(fzf-complete-file)
                            imap <c-x><c-l> <plug>(fzf-complete-line)
                            " Advanced customization using Vim function
                            inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
                        ]], false)
      end,
    }
    use {
      "junegunn/fzf",
      config = function()
        require("plugins.fzf")
      end,
      run = function()
        vim.fn["fzf#install"]()
      end,
    }
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
        vimp.nnoremap({"silent"}, "<leader>Ss", ":SSave!")
        vimp.nnoremap({"silent"}, "<leader>Sl", ":SLoad")
        vimp.nnoremap({"silent"}, "<leader>Sc", ":SClose<cr>")
        vimp.nnoremap({"silent"}, "<leader>Sd", ":SDelete<cr>")
      end,
    }
    -- Quickfix
    use {"kevinhwang91/nvim-bqf"}
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
    -- use {"ms-jpq/kok",
    -- config = function()
    --   lua require("kok/recommends").all()
    -- end,
    -- }
    -- use 'nvim-treesitter/completion-treesitter'
    -- use 'steelsojka/completion-buffers'
    -- use 'nvim-lua/diagnostic-nvim'
    -- Documentation
    use {
      "voldikss/vim-skylight",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "go", ":SkylightJumpTo<cr>")
        vimp.nnoremap({"silent"}, "gp", ":SkylightPreview<cr>")
      end,
      disable = true,
    }
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
          "ansible",
          "contextlib",
          "dask.*",
          "datetime",
          "functools",
          "itertools",
          "json",
          "kartothek.*",
          "logging",
          "numpy.*",
          "os",
          "pandas.*",
          "pickle",
          "pytest",
          "requests",
          "scipy",
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
    -- use {"anihm136/importmagic.nvim", ft = "python"}
    use "stsewd/sphinx.nvim"
    -- Clojure
    use "clojure-vim/vim-jack-in"
    use {"tpope/vim-fireplace", ft = "clojure", cmd = "FireplaceConnect"}
    -- Lua
    use "bfredl/nvim-luadev"
    -- Database
    use "tpope/vim-dadbod"
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("plugins.treesitter")
      end,
    }
    use {
      "nvim-treesitter/nvim-treesitter-refactor",
      requires = "nvim-treesitter/nvim-treesitter",
    }
    use {"nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter"}
    use "tpope/vim-endwise"
    -- Debugger
    use {
      "puremourning/vimspector",
      config = function()
        require("plugins.debugger")
      end,
    }
    -- use {
    --     "mfussenegger/nvim-dap-python",
    --     config = function()
    --         require("dap-python").setup("python")
    --         require("dap-python").test_runner = "pytest"
    --
    --         vimp.nnoremap({"silent"}, "<F4>", require("dap").list_breakpoints)
    --         vimp.nnoremap({"silent"}, "<F5>", require("dap").continue)
    --         vimp.nnoremap({"silent"}, "<F6>", require("dap").repl.toggle)
    --         vimp.nnoremap({"silent"}, "<F8>", require("dap").goto_)
    --         vimp.nnoremap({"silent"}, "<F9>", require("dap").toggle_breakpoint)
    --         vimp.nnoremap(
    --             {"silent"},
    --             "<leader><F9>",
    --             function()
    --                 require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    --             end
    --         )
    --         vimp.nnoremap({"silent"}, "<F10>", require("dap").step_over)
    --         vimp.nnoremap({"silent"}, "<F11>", require("dap").step_into)
    --         vimp.nnoremap({"silent"}, "<F12>", require("dap").step_out)
    --     end,
    --     requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"}
    -- }
    use {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        vim.g.dap_virtual_text = true
      end,
      requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
      run = function()
        vim.cmd("TSUpdate")
      end,
    }
    -- Testing
    use {
      "janko/vim-test",
      config = function()
        require("plugins.test")
      end,
    }
    -- Code folding
    -- use 'kalekundert/vim-coiled-snake'
    use "Konfekt/FastFold"
    use "tmhedberg/SimpylFold"
    -- Syntax highlighters
    use {
      "numirias/semshi",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>rn", ":Semshi rename<cr>")
        vimp.nnoremap({"silent"}, "<Space><Tab>", ":Semshi goto name next<cr>")
        vimp.nnoremap({"silent"}, "<Space><S-Tab>", ":Semshi goto name prev<cr>")
        vimp.nnoremap({"silent"}, "<Space>k", ":Semshi goto class next<cr>")
        vimp.nnoremap({"silent"}, "<Space>K", ":Semshi goto class prev<cr>")
        vimp.nnoremap({"silent"}, "<Space>f", ":Semshi goto function next<cr>")
        vimp.nnoremap({"silent"}, "<Space>F", ":Semshi goto function prev<cr>")
        vimp.nnoremap({"silent"}, "<Space>gu", ":Semshi goto unresolved first<cr>")
        vimp.nnoremap({"silent"}, "<Space>gp", ":Semshi goto parameterUnused first<cr>")
        vimp.nnoremap({"silent"}, "<Space>E", ":Semshi error<cr>")
        vimp.nnoremap({"silent"}, "<Space>ge", ":Semshi goto error<cr>")
      end,
      disable = true,
      ft = "python",
    }
    use {
      "sheerun/vim-polyglot",
      setup = function()
        vim.g.polyglot_disabled = {
          "bash.plugin",
          "c.plugin",
          "clojure.plugin",
          "cpp.plugin",
          "c_sharp.plugin",
          "css.plugin",
          "dart.plugin",
          "elm.plugin",
          "erlang.plugin",
          "fennel.plugin",
          "go.plugin",
          "graphql.plugin",
          "haskell.plugin",
          "html.plugin",
          "java.plugin",
          "javascript.plugin",
          "jsdoc.plugin",
          "json.plugin",
          "julia.plugin",
          "kotlin.plugin",
          "lua.plugin",
          "nix.plugin",
          "ocaml.plugin",
          "ocaml_interface.plugin",
          "ocamllex.plugin",
          "php.plugin",
          "python.plugin",
          "ql.plugin",
          "query.plugin",
          "regex.plugin",
          "rst.plugin",
          "ruby.plugin",
          "rust.plugin",
          "scala.plugin",
          "swift.plugin",
          "teal.plugin",
          "toml.plugin",
          "tsx.plugin",
          "typescript.plugin",
          "verilog.plugin",
          "vue.plugin",
          "yaml.plugin",
        }
      end,
    }
    -- Asciidoc
    use "habamax/vim-asciidoctor"
    -- REPL
    -- use 'ipselium/vim-cpyvke'
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
    -- Tabs
    use "gcmt/taboo.vim"
    -- Color scheme
    use {
      "bluz71/vim-nightfly-guicolors",
      config = function()
        vim.cmd("colorscheme nightfly")
      end,
    }
    use {
      "bluz71/vim-moonfly-colors",
      config = function()
        vim.cmd("colorscheme moonfly")
      end,
      disable = true,
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
      config = function()
        vim.g.indent_blankline_char = "¦"
      end,
    }
    use "Yggdroot/indentLine"
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
    use "tpope/vim-rsi"
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
    use "tommcdo/vim-exchange"
    use "tpope/vim-repeat"
    use "tomtom/tcomment_vim"
    -- Text substitution
    use {
      "svermeulen/vim-subversive",
      after = "vimpeccable",
      config = function()
        vim.cmd [[nmap <leader>s <Plug>(SubversiveSubstitute)]]
        vim.cmd [[nmap <leader>ss <Plug>(SubversiveSubstituteLine)]]
        vim.cmd [[nmap <leader>sl <Plug>(SubversiveSubstituteToEndOfLine)]]

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
    use "jlanzarotta/bufexplorer"
    use "moll/vim-bbye"
    use {
      "wfxr/minimap.vim",
      after = "vimpeccable",
      config = function()
        vimp.nnoremap({"silent"}, "<leader>C", ":MinimapToggle<cr>")
      end,
    }
    -- use 'TaDaa/vimade'
    -- Splits
    -- use 'camspiers/lens.vim'
    -- Tabs
    use "caenrique/nvim-maximize-window-toggle"
    -- Tmux
    use "christoomey/vim-tmux-navigator"
    use "tmux-plugins/vim-tmux-focus-events"
    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        vim.g.nvim_tree_follow = 1
        vim.g.nvim_tree_hide_dotfiles = 1
        vim.g.nvim_tree_git_hl = 1
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
      end,
      disable = true,
    }
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
    use "markonm/traces.vim"
    use {
      "brooth/far.vim",
      config = function()
        vim.g["far#source"] = "rgnvim"

        -- vimp.nnoremap({"silent"}, "<leader>rf", ":Farf<cr>")
        -- vimp.xnoremap({"silent"}, "<leader>rf", ":Farf<cr>")
        -- vimp.nnoremap({"silent"}, "<leader>rr", ":Farr<cr>")
        -- vimp.xnoremap({"silent"}, "<leader>rr", ":Farr<cr>")
      end,
    }
    use {"inkarkat/vim-SearchAlternatives", requires = "inkarkat/vim-ingo-library"}
    -- use 'pgdouyon/vim-evanesco'
    -- use {
    --   "gabrielpoca/replacer.nvim",
    --   config = function()
    --     vimp.nnoremap({"silent"}, "<leader>R", require("replacer").run())
    --   end,
    -- }
    -- Copy/paste
    use "machakann/vim-highlightedyank"
    use {
      "svermeulen/vim-yoink",
      after = "vimpeccable",
      config = function()
        vimp.nmap({"silent"}, "<M-]>", "<Plug>(YoinkPostPasteSwapBack)")
        vimp.nmap({"silent"}, "<M-[>", "<Plug>(YoinkPostPasteSwapForward)")
        vimp.rbind("nx", {"silent"}, "y", "<Plug>(YoinkYankPreserveCursorPosition)")
        vimp.nmap({"silent"}, "p", "<Plug>(YoinkPaste_p)")
        vimp.nmap({"silent"}, "P", "<Plug>(YoinkPaste_P)")
        vimp.nmap({"silent"}, "[y", "<Plug>(YoinkRotateBack)")
        vimp.nmap({"silent"}, "]y", "<Plug>(YoinkRotateForward)")
        vimp.nmap({"silent"}, "<C-=>", "<Plug>(YoinkPostPasteToggleFormat)")
      end,
    }
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
    -- Note taking
    use {"vimwiki/vimwiki", disable = true}
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
    -- Todo
    use "vuciv/vim-bujo"
    -- Unix commands
    use "tpope/vim-eunuch"
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
    -- Benchmark
    use "tweekmonster/startuptime.vim"
    -- Folds
    use "Jorengarenar/vim-syntaxMarkerFold"
    use "~/dev/neovim/pytest.nvim"
  end,
  config = {max_jobs = 32},
})
