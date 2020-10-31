-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

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
        use "junegunn/fzf"
        use "junegunn/fzf.vim"
        use "liuchengxu/vim-clap"
        -- Statusline
        use "itchyny/lightline.vim"
        -- Start screen
        use "mhinz/vim-startify"
        -- LSP
        use "neoclide/coc.nvim"
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
        use "stsewd/sphinx.nvim"
        -- Clojure
        use "clojure-vim/vim-jack-in"
        use "tpope/vim-fireplace"
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
        use "numirias/semshi"
        use "sheerun/vim-polyglot"
        -- REPL
        -- use 'ipselium/vim-cpyvke'
        use "kassio/neoterm"
        use "Olical/conjure"
        -- use "Vigemus/iron.nvim"
        -- Markdown
        use "iamcco/markdown-preview.nvim"
        use "tpope/vim-markdown"
        -- Tabs
        -- use 'akinsho/nvim-bufferline.lua'
        use "gcmt/taboo.vim"
        -- Docker
        -- Color themes
        -- use {"glepnir/zephyr-nvim", config = "require('zephyr')"}
        use {"joshdick/onedark.vim", config = "vim.cmd[[colorscheme onedark]]"}
        -- Icons
        -- use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        -- Cursor
        -- use 'danilamihailov/beacon.nvim'
        -- Brackets
        use "adelarsq/vim-matchit"
        use "cohama/lexima.vim"
        use "luochen1990/rainbow"
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
        use "junegunn/vim-easy-align"
        use "guns/vim-sexp"
        use "tpope/vim-sexp-mappings-for-regular-people"
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
        use "sk1418/Join"
        -- Text objects
        use "chaoren/vim-wordmotion"
        -- use "glts/vim-textobj-comment"
        -- use "julian/vim-textobj-variable-segment"
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
        use "brooth/far.vim"
        use "inkarkat/vim-ingo-library"
        use "inkarkat/vim-SearchAlternatives"
        -- use 'pgdouyon/vim-evanesco'
        -- Copy/paste
        use "machakann/vim-highlightedyank"
        use "svermeulen/vim-yoink"
        -- Discover keybinds
        use "liuchengxu/vim-which-key"
        -- Save position
        use "farmergreg/vim-lastplace"
        -- Note taking
        use "vimwiki/vimwiki"
        -- Dispatcher
        use "skywind3000/asynctasks.vim"
        use "skywind3000/asyncrun.vim"
        use "tpope/vim-dispatch"
        -- Todo
        use "vuciv/vim-bujo"
        -- Unix commands
        use "tpope/vim-eunuch"
        -- Root directory
        use "airblade/vim-rooter"
        -- Autosave
        use "907th/vim-auto-save"
    end
)
