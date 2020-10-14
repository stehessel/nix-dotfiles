" Plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')
" Git
	Plug 'APZelos/blamer.nvim'
	Plug 'jreybert/vimagit'
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-fugitive'
	Plug 'rbong/vim-flog'
	Plug 'rhysd/git-messenger.vim'
" Github
	Plug 'mattn/vim-gist'
" Finders
	Plug 'dyng/ctrlsf.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
" Statusline
	Plug 'itchyny/lightline.vim'
" Start screen
	Plug 'mhinz/vim-startify'
" LSP
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" Plug 'neovim/nvim-lsp'
	" Plug 'nvim-lua/diagnostic-nvim'
" Completion
	" Plug 'nvim-lua/completion-nvim'
	" Plug 'nvim-treesitter/completion-treesitter'
	" Plug 'steelsojka/completion-buffers'
" Linters
	" Plug 'dense-analysis/ale'
" Python
	Plug 'python-rope/ropevim'
	Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }
" Clojure
	Plug 'clojure-vim/vim-jack-in'
	Plug 'tpope/vim-fireplace', { 'for': 'clojure', 'on': 'FireplaceConnect' }
" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter'
" Format
	Plug 'sbdchd/neoformat'
	Plug 'tpope/vim-endwise'
" Snippets
	" Plug 'honza/vim-snippets'
" Debugger
	Plug 'puremourning/vimspector'
" Testing
	Plug 'janko/vim-test'
" Code folding
	" Plug 'kalekundert/vim-coiled-snake'
	Plug 'Konfekt/FastFold'
	Plug 'tmhedberg/SimpylFold'
" Syntax highlighters
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
	Plug 'sheerun/vim-polyglot'
" REPL
	" Plug 'ipselium/vim-cpyvke'
	Plug 'kassio/neoterm'
	Plug 'Olical/conjure', {'tag': 'v4.5.0'}
	Plug 'Vigemus/iron.nvim'
" Markdown
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	Plug 'tpope/vim-markdown'
" Tabs
	" Plug 'akinsho/nvim-bufferline.lua'
	Plug 'gcmt/taboo.vim'
" Docker
" Color themes
	Plug 'arcticicestudio/nord-vim'
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'bluz71/vim-nightfly-guicolors'
	Plug 'chuling/vim-equinusocio-material'
	Plug 'cocopon/iceberg.vim'
	Plug 'flazz/vim-colorschemes'
	Plug 'haishanh/night-owl.vim'
	Plug 'jacoborus/tender.vim'
	Plug 'nanotech/jellybeans.vim'
" Icons
	" Plug "kyazdani42/nvim-web-devicons"
	Plug 'ryanoasis/vim-devicons'
" Cursor
	" Plug 'danilamihailov/beacon.nvim'
" Brackets
	Plug 'adelarsq/vim-matchit'
	Plug 'cohama/lexima.vim'
	Plug 'luochen1990/rainbow'
	Plug 'machakann/vim-sandwich'
" Marks
	Plug 'inkarkat/vim-mark'
	Plug 'kshenoy/vim-signature'
" Indentation
	" Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'tpope/vim-sleuth'
	" Plug 'Yggdroot/indentLine'
" Keybinds
	Plug 'tpope/vim-unimpaired'
" Movement
	Plug 'easymotion/vim-easymotion'
	" Plug 'justinmk/vim-sneak'
	Plug 'rhysd/clever-f.vim'
	" Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'tpope/vim-rsi'
" Text manipulation
	Plug 'AndrewRadev/switch.vim'
	Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
	Plug 'guns/vim-sexp' | 	Plug 'tpope/vim-sexp-mappings-for-regular-people'
	Plug 'matze/vim-move'
	Plug 'machakann/vim-swap'
	" Plug 'mbbill/undotree'
	Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
	Plug 'nicwest/vim-camelsnek'
	Plug 'tommcdo/vim-exchange'
	Plug 'tpope/vim-repeat'
	Plug 'tyru/caw.vim'
" Text substitution
	Plug 'svermeulen/vim-subversive'
	Plug 'tpope/vim-abolish'
" Text splitting
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'sk1418/Join', {'on': 'Join'}
" Text objects
	Plug 'chaoren/vim-wordmotion'
	Plug 'glts/vim-textobj-comment'
	Plug 'julian/vim-textobj-variable-segment'
	Plug 'kana/vim-textobj-user'
	Plug 'michaeljsmith/vim-indent-object'
	Plug 'wellle/targets.vim'
" Buffers
	Plug 'jlanzarotta/bufexplorer'
	Plug 'moll/vim-bbye'
	" Plug 'TaDaa/vimade'
" Splits
	" Plug 'camspiers/lens.vim'
" Tabs
	Plug 'caenrique/nvim-maximize-window-toggle'
" Tmux
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux-focus-events'
" File explorer
	" Plug 'lambdalisue/fern.vim'
	" Plug 'lambdalisue/fern-bookmark.vim'
	" Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Projects
	Plug 'tpope/vim-projectionist'
" Search
	Plug 'brooth/far.vim', { 'do': ':UpdateRemotePlugins' }
	Plug 'inkarkat/vim-ingo-library'
	Plug 'inkarkat/vim-SearchAlternatives'
	" Plug 'pgdouyon/vim-evanesco'
" Copy/paste
	Plug 'machakann/vim-highlightedyank'
	Plug 'svermeulen/vim-yoink'
" Discover keybinds
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Save position
	Plug 'farmergreg/vim-lastplace'
" Note taking
	Plug 'vimwiki/vimwiki'
" Dispatcher
	Plug 'skywind3000/asynctasks.vim'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'tpope/vim-dispatch'
" Todo
	Plug 'vuciv/vim-bujo'
" Unix commands
	Plug 'tpope/vim-eunuch'
" Root directory
	Plug 'airblade/vim-rooter'
" Autosave
	Plug '907th/vim-auto-save'
" Local
	Plug '~/git/nvim-jira'
call plug#end()

" Misc keybinds
	let mapleader =","
	let maplocalleader = "\\"
	map U :redo<CR>
	map Y y$
	noremap <leader>s :w<CR>
	noremap <leader>q :q<CR>
	noremap ? ,
	nnoremap <silent> <C-l> :<C-u>nohl<CR><C-l>
	noremap <plug>(slash-after) zz
	imap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>
	set nocompatible
" Macros
	nnoremap Q @q
" Line breaks
	set linebreak
	set breakindent
" Auto save
	let g:auto_save        = 0
	let g:auto_save_silent = 1
	let g:auto_save_events = ["InsertLeave", "FocusLost"]
" Sessions
	set sessionoptions+=tabpages,globals,winpos,winsize,blank,resize
	" do not store global and local values in a session
	set sessionoptions-=options
	" do not store folds
	set sessionoptions-=folds
" Startify
	map <leader>h :Startify<CR>
" Vim rooter
	let g:rooter_silent_chdir = 1
" Yank whole buffer
	nmap <leader>Y :%y<CR>
" Select whole buffer
	nmap <leader>V ggVG
" Delete whole buffer
	nmap <leader>D :%d<CR>
" Visual mode
	nnoremap <M-v> <C-v>
" Buffers
	nmap <leader>bn :bn<CR>
	nmap <leader>bp :bp<CR>
	nmap <leader>bd :bd<CR>
	nnoremap gj <C-^>
" Tabs
	nnoremap g[ :-tabmove<CR>
	nnoremap g] :+tabmove<CR>
	nnoremap g^ :tabm 0<CR>
	nnoremap g$ :tabm<CR>
	nnoremap <C-t> :tabnew<CR>
	nnoremap <leader><space> :ToggleOnly<Enter>
" Splits
	" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitright splitbelow

	noremap <C-s> <C-w>S
	noremap <C-v> <C-w>v
	noremap <C-q> <C-w>q
	" map <C-h> <C-w>h
	" map <C-j> <C-w>j
	" map <C-k> <C-w>k
	" map <C-l> <C-w>l
	nnoremap <C-m> <C-w>w
	" Open alternative file in split
	noremap gk :vs#<CR>
" Quickfix
	nnoremap <silent> <leader>ko :copen<CR>
	nnoremap <silent> <leader>kc :cclose<CR>
" Startify
	let g:startify_session_persistence = 1
	let g:startify_update_oldfiles = 1

	nmap <leader>Ss :SSave!
	nmap <leader>Sl :SLoad
	nmap <leader>Sc :SClose<CR>
	nmap <leader>Sd :SDelete<CR>
" Reloading
	set autoread
	" Trigger `autoread` when files changes on disk
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
	" Notification after file change
	autocmd FileChangedShellPost *
		\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" Lens
	" let g:lens#disabled_filetypes = ['coc-explorer', 'nerdtree', 'fzf']
" Theme
	set bg=dark
	set termguicolors
	let g:rainbow_active = 1
" Color theme
	colorscheme nightfly

	let g:equinusocio_material_darker = 1
	let g:equinusocio_material_hide_vertsplit = 0

	let g:jellybeans_overrides = {
		\ 'Todo': { 'ctermfg': 'Black', 'ctermbg': 'Grey', 'attr': 'bold' },
		\ }
	let g:jellybeans_use_lowcolor_black = 1
	let g:jellybeans_use_term_italics = 1
" Highlighters
	highlight HighlightedyankRegion cterm=reverse gui=reverse
	highlight CursorColumn cterm=reverse gui=reverse
	highlight CursorLine cterm=reverse gui=reverse
" Text
	set encoding=utf-8
	set tabstop=4
	set shiftwidth=4
	set whichwrap+=<,>,h,l,[,]
	syntax on
	set updatetime=100
	set nofoldenable
" Title
	set title
" Line numbers
	set number
	nmap <leader>N :set number relativenumber!<CR>
" Undo
	set undofile
	set undodir=~/.config/nvim/undo
" Mouse
	set mouse=a
" Rendering
	set lazyredraw
" Filetype
	filetype plugin indent on
	set suffixesadd=.md
" Vim sneak
	" map f <Plug>Sneak_s
	" map F <Plug>Sneak_S
	" map f <Plug>Sneak_f
	" map F <Plug>Sneak_F
	" map t <Plug>Sneak_t
	" map T <Plug>Sneak_T
" Quick-scope
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Disables automatic commenting on newline:
	" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Fern
	let g:fern#renderer = "nerdfont"
	let g:fern#disable_default_mappings = 1

	nmap <silent> <leader>Ee :Fern . -drawer -reveal=% -toggle<CR>
	nmap <silent> <leader>Ef :Fern . -drawer -reveal=%<CR>
	nmap <silent> <leader>Eb :Fern bookmark:/// -drawer <CR>

	" function! s:fern_init() abort
	" 	nmap <buffer> o <Plug>(fern-action-open:edit)
	" 	nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
	" 	nmap <buffer> t <Plug>(fern-action-open:tabedit)
	" 	nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
	" 	nmap <buffer> i <Plug>(fern-action-open:split)
	" 	nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
	" 	nmap <buffer> s <Plug>(fern-action-open:vsplit)
	" 	nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p

	" 	nmap <buffer> P gg

	" 	nmap <buffer> C <Plug>(fern-action-enter)
	" 	nmap <buffer> u <Plug>(fern-action-leave)
	" 	nmap <buffer> r <Plug>(fern-action-reload)
	" 	nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
	" 	nmap <buffer> cd <Plug>(fern-action-cd)
	" 	nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>

	" 	nmap <buffer> I <Plug>(fern-action-hide-toggle)

	" 	nmap <buffer> q :<C-u>quit<CR>
	" endfunction

	" augroup fern-custom
	" 	autocmd! *
	" 	autocmd FileType fern call s:init_fern()
	" augroup END
" Vim-wiki
	" let g:vimwiki_list = [ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'} ]
" Plug commands
	command! PU PlugUpdate | PlugUpgrade
" Vim-which-key
	nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Undotree
	nnoremap <leader>u :UndotreeToggle<CR>
" AsyncTasks
	" Height of quick fix window
	let g:asyncrun_open = 12
" Sources
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/copy.vim
	source ~/.config/nvim/dev.vim
	source ~/.config/nvim/edit.vim
	source ~/.config/nvim/format.vim
	source ~/.config/nvim/git.vim
	" source ~/.config/nvim/linters.vim
	" source ~/.config/nvim/lsp.vim
	source ~/.config/nvim/projects.vim
	source ~/.config/nvim/providers.vim
	source ~/.config/nvim/python.vim
	source ~/.config/nvim/repl.vim
	source ~/.config/nvim/search.vim
	source ~/.config/nvim/statusline.vim
	source ~/.config/nvim/text.vim

	" lua require'bufferline'.setup()
	" lua require'nvim-web-devicons'.setup()
	lua require('treesitter')
