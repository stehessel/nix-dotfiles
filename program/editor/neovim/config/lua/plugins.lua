-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

if not packer_exists then
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
        vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")

    return
end

return require("packer").startup(
    {
        function()
            -- Packer can manage itself as an optional plugin
            use {"wbthomason/packer.nvim", opt = true}

            use {
                "svermeulen/vimpeccable",
                config = function()
                    require("vimp")
                end
            }

            -- Git
            use "APZelos/blamer.nvim"
            use "jreybert/vimagit"
            use {
                "mhinz/vim-signify",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>vl", ":SignifyList<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vd", ":SignifyDiff<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vf", ":SignifyFold<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vv", ":SignifyHunkDiff<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vu", ":SignifyHunkUndo<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vr", ":SignifyRefresh<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vt", ":SignifyToggle<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vh", ":SignifyToggleHighlight<cr>")

                    vimp.onoremap({"silent"}, "ig", "<plug>(signify-motion-inner-pending)")
                    vimp.xnoremap({"silent"}, "ig", "<plug>(signify-motion-inner-visual)")
                    vimp.onoremap({"silent"}, "ag", "<plug>(signify-motion-outer-pending)")
                    vimp.xnoremap({"silent"}, "ag", "<plug>(signify-motion-outer-visual)")

                    vim.cmd [[highlight SignifySignDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
                    vim.cmd [[highlight SignifyLineDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
                end
            }
            use "tpope/vim-fugitive"
            use "rbong/vim-flog"
            use "rhysd/git-messenger.vim"
            -- Github
            use "mattn/vim-gist"
            -- Finders
            use "dyng/ctrlsf.vim"
            use {
                "junegunn/fzf.vim",
                requires = {
                    "junegunn/fzf",
                    run = function()
                        vim.fn["fzf#install"]()
                    end
                }
            }
            use {
                "liuchengxu/vim-clap",
                run = function()
                    vim.fn["clap#installer#build_all"]()
                end
            }
            -- Statusline
            use "itchyny/lightline.vim"
            -- Start screen
            use {
                "mhinz/vim-startify",
                config = function()
                    vim.g.startify_session_persistence = 1
                    vim.g.startify_update_oldfiles = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>h", ":Startify<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Ss", ":SSave!")
                    vimp.nnoremap({"silent"}, "<leader>Sl", ":SLoad")
                    vimp.nnoremap({"silent"}, "<leader>Sc", ":SClose<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Sd", ":SDelete<cr>")
                end
            }
            -- LSP
            use {
                "neoclide/coc.nvim",
                run = function()
                    vim.fn["coc#util#install"]()
                end
                -- config = function()
                --     require("coc")
                -- end
            }
            -- use 'neovim/nvim-lsp'
            -- use 'nvim-lua/diagnostic-nvim'
            -- Completion
            -- use 'nvim-lua/completion-nvim'
            -- use 'nvim-treesitter/completion-treesitter'
            -- use 'steelsojka/completion-buffers'
            -- Linters
            -- use 'dense-analysis/ale'
            -- Python
            use {
                "python-rope/ropevim",
                -- after = "vimpeccable",
                config = function()
                    vim.g.ropevim_local_prefix = "<M-r>"
                    vim.g.ropevim_global_prefix = "<M-p>"
                    vim.g.ropevim_autoimport_modules = {"*"}
                    vim.g.ropevim_enable_autoimport = 1
                    vim.g.ropevim_guess_project = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<M-,>", ":RopeCodeAssist<cr>")
                    vimp.nnoremap({"silent"}, "<M-.>", ":RopeLuckyAssist<cr>")
                    vimp.nnoremap({"silent"}, "<M-CR>", ":RopeAutoImport<cr>")
                    vimp.nnoremap({"silent"}, "<M-d>", ":RopeGotoDefinition<cr>")
                end,
                ft = "python"
            }
            use {
                "stsewd/sphinx.nvim",
                run = function()
                    vim.cmd [[:UpdateRemotePlugins]]
                end
            }
            -- Clojure
            use "clojure-vim/vim-jack-in"
            use {"tpope/vim-fireplace", ft = "clojure", cmd = "FireplaceConnect"}
            -- Treesitter
            use {
                "nvim-treesitter/nvim-treesitter",
                config = function()
                    require("treesitter")
                end
            }
            -- Format
            use {
                "sbdchd/neoformat",
                config = function()
                    vim.cmd [[augroup format]]
                    vim.cmd [[autocmd!]]
                    vim.cmd [[autocmd BufWritePre *.lua,*.py,*.sql undojoin | Neoformat]]
                    vim.cmd [[augroup END]]

                    vim.g.neoformat_enabled_lua = {"luafmt"}
                    vim.g.neoformat_enabled_python = {"black"}
                    vim.g.neoformat_enabled_sql = {"pg_format"}
                    vim.g.neoformat_enabled_yaml = {"prettier"}
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>F", ":Neoformat<cr>")
                end
            }
            use "tpope/vim-endwise"
            -- Snippets
            -- use 'honza/vim-snippets'
            -- Debugger
            use "puremourning/vimspector"
            -- Testing
            use "janko/vim-test"
            -- Code folding
            -- use 'kalekundert/vim-coiled-snake'
            use "Konfekt/FastFold"
            use "tmhedberg/SimpylFold"
            -- Syntax highlighters
            use {
                "numirias/semshi",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>rn", ":Semshi rename<cr>")

                    vimp.nnoremap({"silent"}, "<Space><Tab>", ":Semshi goto name next<cr>")
                    vimp.nnoremap({"silent"}, "<Space><S-Tab>", ":Semshi goto name prev<cr>")

                    vimp.nnoremap({"silent"}, "<Space>k", ":Semshi goto class next<cr>")
                    vimp.nnoremap({"silent"}, "<Space>K", ":Semshi goto class prev<cr>")

                    vimp.nnoremap({"silent"}, "<Space>f", ":Semshi goto function next<cr>")
                    vimp.nnoremap({"silent"}, "<Space>F", ":Semshi goto function prev<cr>")

                    vimp.nnoremap({"silent"}, "<Space>gu", ":Semshi goto unresolved first<cr>")
                    vimp.nnoremap({"silent"}, "<Space>gp", ":Semshi goto parameterUnused first<cr>")

                    vimp.nnoremap({"silent"}, "<Space>ee", ":Semshi error<cr>")
                    vimp.nnoremap({"silent"}, "<Space>ge", ":Semshi goto error<cr>")
                end,
                ft = "python",
                run = function()
                    vim.cmd [[:UpdateRemotePlugins]]
                end
            }
            use "sheerun/vim-polyglot"
            -- REPL
            -- use 'ipselium/vim-cpyvke'
            use {
                "kassio/neoterm",
                -- after = "vimpeccable",
                config = function()
                    vim.g.neoterm_default_mod = "rightbelow vertical"
                    vim.g.neoterm_autoinsert = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>Tt", ":Ttoggle<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tr", ":TREPLSetTerm<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tf", ":TREPLSendFile<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tl", ":TREPLSendLine<cr>")
                    vimp.xnoremap({"silent"}, "<leader>Tl", ":TREPLSendSelection<cr>")
                    -- Use gx{text-object} in normal mode
                    vimp.nnoremap({"silent"}, "gx", "<plug>(neoterm-repl-send)")
                    -- Send selected contents in visual mode.
                    vimp.xnoremap({"silent"}, "gx", "<plug>(neoterm-repl-send)")
                end
            }
            use {
                "Olical/conjure",
                config = function()
                    vim.cmd [[let g:conjure#log#hud#width = 0.42]]
                end,
                ft = {"clojure", "fennel"}
            }
            use {
                "Vigemus/iron.nvim",
                -- after = "vimpeccable",
                config = function()
                    local iron = require("iron")

                    iron.core.set_config {
                        preferred = {
                            python = "ipython"
                        }
                    }

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<M-,>", ":IronRepl python<cr><esc>")
                    vimp.nnoremap({"silent"}, "<leader>it", ":IronRepl python<cr><ESC>")
                    vimp.nnoremap({"silent"}, "<leader>if", ":IronFocus python<cr>")
                    vimp.nnoremap({"silent"}, "<leader>ir", ":IronRestart<cr>")
                    vimp.nnoremap({"silent"}, "<leader>iw", ":IronWatchCurrentFile")
                    vimp.nnoremap({"silent"}, "<leader>iu", ":IronUnwatchCurrentFile<cr>")

                    vimp.nnoremap({"silent"}, "<localleader>s", "<plug>(iron-send-motion)")
                    vimp.vnoremap({"silent"}, "<localleader>s", "<plug>(iron-visual-send)")
                    vimp.vnoremap({"silent"}, "<localleader>r", "<plug>(iron-repeat-cmd)")
                    vimp.vnoremap({"silent"}, "<localleader>l", "<plug>(iron-send-line)")
                    vimp.vnoremap({"silent"}, "<localleader><cr>", "<plug>(iron-cr)")
                    vimp.vnoremap({"silent"}, "<localleader>i", "<plug>(iron-interrupt)")
                    vimp.vnoremap({"silent"}, "<localleader>q", "<plug>(iron-exit)")
                    vimp.vnoremap({"silent"}, "<localleader>c", "<plug>(iron-clear)")
                end
            }
            -- Markdown
            use {
                "iamcco/markdown-preview.nvim",
                run = function()
                    vim.fn["mkdp#util#install"]()
                end
            }
            use "tpope/vim-markdown"
            -- Tabs
            use "gcmt/taboo.vim"
            -- Color scheme
            use {
                "sainnhe/sonokai",
                config = function()
                    vim.g.sonokai_style = "atlantis"
                    vim.g.sonokai_enable_itatlic = 1
                    vim.g.sonokai_diagnostic_line_highlight = 1
                    vim.g.sonokai_better_performance = 1
                    vim.cmd("colorscheme sonokai")
                end
            }
            -- Icons
            use "kyazdani42/nvim-web-devicons"
            -- Brackets
            use "adelarsq/vim-matchit"
            use "cohama/lexima.vim"
            use {
                "luochen1990/rainbow",
                setup = function()
                    vim.g.rainbow_active = 1
                end
            }
            use "machakann/vim-sandwich"
            -- Marks
            use "inkarkat/vim-mark"
            use "kshenoy/vim-signature"
            -- Indentation
            -- use 'lukas-reineke/indent-blankline.nvim'
            use "tpope/vim-sleuth"
            -- use 'Yggdroot/indentLine'
            -- Keybinds
            use "tpope/vim-unimpaired"
            -- Movement
            use "easymotion/vim-easymotion"
            use "rhysd/clever-f.vim"
            use "tpope/vim-rsi"
            -- Text manipulation
            use {
                "AndrewRadev/switch.vim",
                config = function()
                    vim.g.switch_mapping = "-"
                end
            }
            use {
                "junegunn/vim-easy-align",
                -- after = "vimpeccable",
                cmd = "EasyAlign",
                setup = function()
                    require("vimp")
                    -- Start interactive EasyAlign in visual mode (e.g. vipga)
                    vimp.xnoremap({"silent"}, "ga", ":EasyAlign<cr>")
                    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
                    vimp.nnoremap({"silent"}, "ga", ":EasyAlign<cr>")
                end
            }
            use {"tpope/vim-sexp-mappings-for-regular-people", ft = {"clojure", "fennel"}, after = "vim-sexp"}
            use {
                "guns/vim-sexp",
                config = function()
                    vim.g.sexp_enable_insert_mode_mappings = 0
                end,
                ft = {"clojure", "fennel"}
            }
            use "matze/vim-move"
            use {
                "machakann/vim-swap",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.onoremap({"silent"}, "i,", "<plug>(swap-textobject-i)")
                    vimp.xnoremap({"silent"}, "i,", "<plug>(swap-textobject-i)")
                    vimp.onoremap({"silent"}, "a,", "<plug>(swap-textobject-a)")
                    vimp.xnoremap({"silent"}, "a,", "<plug>(swap-textobject-a)")
                end
            }
            use "mg979/vim-visual-multi"
            use {
                "nicwest/vim-camelsnek",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
                end
            }
            use "tommcdo/vim-exchange"
            use "tpope/vim-repeat"
            use "tyru/caw.vim"
            -- Text substitution
            use {
                "svermeulen/vim-subversive",
                -- after = "vimpeccable",
                config = function()
                    vim.cmd [[nmap s <plug>(SubversiveSubstitute)]]
                    vim.cmd [[nmap ss <plug>(SubversiveSubstituteLine)]]
                    vim.cmd [[nmap sl <plug>(SubversiveSubstituteToEndOfLine)]]

                    vim.cmd [[xmap s <plug>(SubversiveSubstitute)]]
                    vim.cmd [[xmap p <plug>(SubversiveSubstitute)]]
                    vim.cmd [[xmap P <plug>(SubversiveSubstitute)]]

                    vim.cmd [[nmap <leader><leader>s <plug>(SubversiveSubvertRange)]]
                    vim.cmd [[xmap <leader><leader>s <plug>(SubversiveSubvertRange)]]
                    vim.cmd [[nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)]]

                    vim.cmd [[nmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)]]
                    vim.cmd [[xmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)]]
                    vim.cmd [[nmap <leader>css <plug>(SubversiveSubstituteWordRangeConfirm)]]

                    require("vimp")
                    -- ie = inner entire buffer
                    vimp.onoremap({"silent"}, "ie", [[:exec "normal! ggVG"<cr>]])
                    -- iv = current viewable text in the buffer
                    vimp.onoremap({"silent"}, "iv", [[:exec "normal! HVL"<cr>]])
                end
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
                        ["<C-R><C-W>"] = "<C-R><M-w>"
                    }
                end
            }
            use "glts/vim-textobj-comment"
            use "julian/vim-textobj-variable-segment"
            use "kana/vim-textobj-user"
            use "michaeljsmith/vim-indent-object"
            use "wellle/targets.vim"
            -- Buffers
            use "jlanzarotta/bufexplorer"
            use "moll/vim-bbye"
            -- use 'TaDaa/vimade'
            -- Splits
            -- use 'camspiers/lens.vim'
            -- Tabs
            use "caenrique/nvim-maximize-window-toggle"
            -- Tmux
            use "christoomey/vim-tmux-navigator"
            use "tmux-plugins/vim-tmux-focus-events"
            -- File explorer
            -- use 'lambdalisue/fern.vim'
            -- use 'lambdalisue/fern-bookmark.vim'
            -- use 'lambdalisue/fern-renderer-nerdfont.vim'
            -- Projects
            use {
                "tpope/vim-projectionist",
                config = function()
                    vim.g.projectionist_heuristics = {["data_catalog/*.py"] = {["alternate"] = "tests/unit/test_{}.py"}}

                    require("vimp")
                    vimp.nnoremap({"silent"}, "go", ":A<cr>")
                end
            }
            -- Search
            use {
                "brooth/far.vim",
                run = function()
                    vim.cmd [[:UpdateRemotePlugins]]
                end
            }
            use {"inkarkat/vim-SearchAlternatives", requires = "inkarkat/vim-ingo-library"}
            -- use 'pgdouyon/vim-evanesco'
            -- Copy/paste
            use "machakann/vim-highlightedyank"
            use {
                "svermeulen/vim-yoink",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<M-]>", "YoinkPostPasteSwapBack")
                    vimp.nnoremap({"silent"}, "<M-[>", "YoinkPostPasteSwapForward")

                    vimp.nnoremap({"silent"}, "y", "YoinkYankPreserveCursorPosition")
                    vimp.xnoremap({"silent"}, "y", "YoinkYankPreserveCursorPosition")

                    vimp.nnoremap({"silent"}, "p", "YoinkPaste_p")
                    vimp.nnoremap({"silent"}, "P", "YoinkPaste_P")

                    vimp.nnoremap({"silent"}, "[y", "YoinkRotateBack")
                    vimp.nnoremap({"silent"}, "]y", "YoinkRotateForward")

                    vimp.nnoremap({"silent"}, "<C-=>", "YoinkPostPasteToggleFormat")
                end
            }
            -- Discover keybinds
            use {
                "liuchengxu/vim-which-key",
                cmd = {"WhichKey"},
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>", ":WhichKey '<leader>'<cr>")
                end
            }
            -- Save position
            use "farmergreg/vim-lastplace"
            -- Note taking
            use "vimwiki/vimwiki"
            -- Dispatcher
            use {
                "skywind3000/asynctasks.vim",
                cmd = {"AsyncTask", "AsyncTaskEdit", "AsyncTaskList", "AsyncTaskMacro", "AsyncTaskProfile"},
                requires = {
                    "skywind3000/asyncrun.vim",
                    setup = function()
                        vim.g.asyncrun_open = 12
                    end
                }
            }
            use {"tpope/vim-dispatch", cmd = {"Dispatch", "Make", "Focus", "Start"}}
            -- Todo
            use "vuciv/vim-bujo"
            -- Unix commands
            use "tpope/vim-eunuch"
            -- Root directory
            use "airblade/vim-rooter"
            -- Autosave
            use {
                "907th/vim-auto-save",
                setup = function()
                    vim.g.auto_save = 0
                    vim.g.auto_save_silent = 1
                    vim.g.auto_save_events = {"InsertLeave", "FocusLost"}
                end
            }
            -- Benchmark
            use "tweekmonster/startuptime.vim"
        end,
        config = {max_jobs = 64}
    }
)
