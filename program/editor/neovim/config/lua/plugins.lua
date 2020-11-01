-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[ packadd packer.nvim ]])

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
    function()
        -- Packer can manage itself as an optional plugin
        use {"wbthomason/packer.nvim", opt = true}

        -- Git
        use "APZelos/blamer.nvim"
        use "jreybert/vimagit"
        use "mhinz/vim-signify"
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

                vim.api.nvim_set_keymap("n", "<leader>h", ":Startify<CR>", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<leader>Ss", ":SSave!", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<leader>Sl", ":SLoad", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<leader>Sc", ":SClose<CR>", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<leader>Sd", ":SDelete<CR>", {noremap = true, silent = true})
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
            config = function()
                vim.g.ropevim_local_prefix = "<M-r>"
                vim.g.ropevim_global_prefix = "<M-p>"
                vim.g.ropevim_autoimport_modules = {"*"}
                vim.g.ropevim_enable_autoimport = 1
                vim.g.ropevim_guess_project = 1

                vim.api.nvim_set_keymap("n", "<M-,>", ":call RopeCodeAssist()<CR>", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<M-.>", ":call RopeLuckyAssist<CR>", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<M-CR>", ":call RopeAutoImport<CR>", {noremap = true, silent = true})
                vim.api.nvim_set_keymap("n", "<M-d>", "call RopeGotoDefinition<CR>", {noremap = true, silent = true})
            end,
            ft = "python"
        }
        use {
            "stsewd/sphinx.nvim",
            run = function()
                vim.cmd [[ :UpdateRemotePlugins ]]
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
        use "sbdchd/neoformat"
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
            config = function()
                vim.cmd [[ nmap <silent> <leader>rn :Semshi rename<CR> ]]

                vim.cmd [[ nmap <silent> <space><Tab> :Semshi goto name next<CR> ]]
                vim.cmd [[ nmap <silent> <space><S-Tab> :Semshi goto name prev<CR> ]]

                vim.cmd [[ nmap <silent> <space>k :Semshi goto class next<CR> ]]
                vim.cmd [[ nmap <silent> <space>K :Semshi goto class prev<CR> ]]

                vim.cmd [[ nmap <silent> <space>f :Semshi goto function next<CR> ]]
                vim.cmd [[ nmap <silent> <space>F :Semshi goto function prev<CR> ]]

                vim.cmd [[ nmap <silent> <space>gu :Semshi goto unresolved first<CR> ]]
                vim.cmd [[ nmap <silent> <space>gp :Semshi goto parameterUnused first<CR> ]]

                vim.cmd [[ nmap <silent> <space>ee :Semshi error<CR> ]]
                vim.cmd [[ nmap <silent> <space>ge :Semshi goto error<CR> ]]
            end,
            ft = "python",
            run = function()
                vim.cmd [[ :UpdateRemotePlugins ]]
            end
        }
        -- use "sheerun/vim-polyglot"
        -- REPL
        -- use 'ipselium/vim-cpyvke'
        use {
            "kassio/neoterm",
            config = function()
                vim.g.neoterm_default_mod = "rightbelow vertical"
                vim.g.neoterm_autoinsert = 1

                vim.cmd [[nnoremap <leader>Tt :Ttoggle<CR>]]
                vim.cmd [[nnoremap <leader>Tr :TREPLSetTerm<CR>]]
                vim.cmd [[nnoremap <leader>Tf :TREPLSendFile<CR>]]
                vim.cmd [[nnoremap <leader>Tl :TREPLSendLine<CR>]]
                vim.cmd [[vnoremap <leader>Tl :TREPLSendSelection<CR>]]
                -- Use gx{text-object} in normal mode
                vim.cmd [[nmap gx <Plug>(neoterm-repl-send)]]
                -- Send selected contents in visual mode.
                vim.cmd [[xmap gx <Plug>(neoterm-repl-send)]]
            end
        }
        use {
            "Olical/conjure",
            config = function()
                vim.cmd [[ let g:conjure#log#hud#width = 0.42 ]]
            end,
            ft = {"clojure", "fennel"}
        }
        use {
            "Vigemus/iron.nvim",
            config = function()
                local iron = require("iron")

                iron.core.set_config {
                    preferred = {
                        python = "ipython"
                    }
                }

                vim.cmd [[nmap <leader>it  :IronRepl python<CR><ESC>]]
                vim.cmd [[nmap <leader>if  :IronFocus python<CR>]]
                vim.cmd [[nmap <leader>ir  :IronRestart<CR>]]
                vim.cmd [[nmap <leader>iw  :IronWatchCurrentFile]]
                vim.cmd [[nmap <leader>iu  :IronUnwatchCurrentFile<CR>]]

                vim.cmd [[nmap <localleader>s    <Plug>(iron-send-motion)]]
                vim.cmd [[vmap <localleader>s    <Plug>(iron-visual-send)]]
                vim.cmd [[nmap <localleader>r    <Plug>(iron-repeat-cmd)]]
                vim.cmd [[nmap <localleader>l    <Plug>(iron-send-line)]]
                vim.cmd [[nmap <localleader><CR> <Plug>(iron-cr)]]
                vim.cmd [[nmap <localleader>i    <plug>(iron-interrupt)]]
                vim.cmd [[nmap <localleader>q    <Plug>(iron-exit)]]
                vim.cmd [[nmap <localleader>c    <Plug>(iron-clear)]]
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
        -- use 'akinsho/nvim-bufferline.lua'
        use "gcmt/taboo.vim"
        -- Docker

        -- Color themes
        -- use {"glepnir/zephyr-nvim", config = "require('zephyr')"}
        -- use {"joshdick/onedark.vim", config = "vim.cmd [[colorscheme onedark]]"}
        use {
            "kyazdani42/blue-moon",
            config = function()
                vim.cmd [[ colorscheme blue-moon ]]
            end
        }

        -- Icons
        -- use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        -- Cursor
        -- use 'danilamihailov/beacon.nvim'
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
        -- use 'justinmk/vim-sneak'
        use "rhysd/clever-f.vim"
        -- use 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
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
            cmd = "EasyAlign",
            setup = function()
                -- Start interactive EasyAlign in visual mode (e.g. vipga)
                vim.cmd [[xmap <silent> ga :EasyAlign<CR>]]
                -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
                vim.cmd [[nmap <silent> ga :EasyAlign<CR>]]
            end
        }
        use {"tpope/vim-sexp-mappings-for-regular-people", ft = "clojure", after = "vim-sexp"}
        use {"guns/vim-sexp", ft = "clojure"}
        use "matze/vim-move"
        use {
            "machakann/vim-swap",
            config = function()
                vim.cmd [[omap i, <Plug>(swap-textobject-i)]]
                vim.cmd [[xmap i, <Plug>(swap-textobject-i)]]
                vim.cmd [[omap a, <Plug>(swap-textobject-a)]]
                vim.cmd [[xmap a, <Plug>(swap-textobject-a)]]
            end
        }
        -- use 'mbbill/undotree'
        use "mg979/vim-visual-multi"
        use {
            "nicwest/vim-camelsnek",
            config = function()
                vim.cmd [[map <leader>xs :Snek<CR>]]
                vim.cmd [[map <leader>xc :Camel<CR>]]
                vim.cmd [[map <leader>xb :CamelB<CR>]]
                vim.cmd [[map <leader>xk :Kebab<CR>]]
            end
        }
        use "tommcdo/vim-exchange"
        use "tpope/vim-repeat"
        use "tyru/caw.vim"
        -- Text substitution
        use {
            "svermeulen/vim-subversive",
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

                -- ie = inner entire buffer
                vim.cmd [[ onoremap ie :exec "normal! ggVG"<cr> ]]
                -- iv = current viewable text in the buffer
                vim.cmd [[ onoremap iv :exec "normal! HVL"<cr> ]]
            end
        }
        use "tpope/vim-abolish"
        -- Text splitting
        use "AndrewRadev/splitjoin.vim"
        use {"sk1418/Join", cmd = "Join"}
        -- Text objects
        use "chaoren/vim-wordmotion"
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

                vim.cmd [[ nnoremap go :A<CR> ]]
            end
        }
        -- Search
        use {
            "brooth/far.vim",
            run = function()
                vim.cmd [[:UpdateRemotePlugins]]
            end
        }
        use "inkarkat/vim-ingo-library"
        use "inkarkat/vim-SearchAlternatives"
        -- use 'pgdouyon/vim-evanesco'
        -- Copy/paste
        use "machakann/vim-highlightedyank"
        use "svermeulen/vim-yoink"
        -- Discover keybinds
        use {"liuchengxu/vim-which-key", cmd = {"WhichKey"}}
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
    end
)
