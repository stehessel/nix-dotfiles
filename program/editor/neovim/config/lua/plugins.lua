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

                vim.cmd [[ nnoremap <leader>h :Startify<CR> ]]
                vim.cmd [[ nnoremap <leader>Ss :SSave! ]]
                vim.cmd [[ nnoremap <leader>Sl :SLoad ]]
                vim.cmd [[ nnoremap <leader>Sc :SClose<CR> ]]
                vim.cmd [[ nnoremap <leader>Sd :SDelete<CR> ]]
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
        use "python-rope/ropevim"
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
        use {"nvim-treesitter/nvim-treesitter", config = "require('treesitter')"}
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
            ft = "python",
            run = function()
                vim.cmd [[ :UpdateRemotePlugins ]]
            end
        }
        -- use "sheerun/vim-polyglot"
        -- REPL
        -- use 'ipselium/vim-cpyvke'
        use "kassio/neoterm"
        use {"Olical/conjure", ft = {"clojure", "fennel"}}
        -- use "Vigemus/iron.nvim"
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
        use "AndrewRadev/switch.vim"
        use {"junegunn/vim-easy-align", cmd = "EasyAlign"}
        use {"tpope/vim-sexp-mappings-for-regular-people", ft = "clojure"}
        use {"guns/vim-sexp", ft = "clojure"}
        use "matze/vim-move"
        use "machakann/vim-swap"
        -- use 'mbbill/undotree'
        use "mg979/vim-visual-multi"
        use "nicwest/vim-camelsnek"
        use "tommcdo/vim-exchange"
        use "tpope/vim-repeat"
        use "tyru/caw.vim"
        -- Text substitution
        use "svermeulen/vim-subversive"
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
        use "tpope/vim-projectionist"
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
