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
	Plug 'neovim/nvim-lsp'
	Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }
	" Plug 'liuchengxu/vista.vim'
" Linters
" 	Plug 'dense-analysis/ale'
" Auto format
	Plug 'Chiel92/vim-autoformat'
" Auto complete
	Plug 'haorenW1025/completion-nvim'
" Snippets
	Plug 'honza/vim-snippets'
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
	Plug 'Vigemus/iron.nvim'
" Markdown
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	Plug 'tpope/vim-markdown'
" Tabs
	Plug 'gcmt/taboo.vim'
" Docker
" Color themes
	Plug 'arcticicestudio/nord-vim'
	Plug 'chuling/vim-equinusocio-material'
	Plug 'cocopon/iceberg.vim'
	Plug 'flazz/vim-colorschemes'
	Plug 'haishanh/night-owl.vim'
	Plug 'jacoborus/tender.vim'
	Plug 'nanotech/jellybeans.vim'
" Icons
	Plug 'ryanoasis/vim-devicons'
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
	Plug 'Yggdroot/indentLine'
" Keybinds
	Plug 'tpope/vim-unimpaired'
" Movement
	Plug 'easymotion/vim-easymotion'
	Plug 'justinmk/vim-sneak'
	Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'tpope/vim-rsi'
	Plug 'unblevable/quick-scope'
" Text manipulation
	Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
	Plug 'matze/vim-move'
	Plug 'machakann/vim-swap'
	" Plug 'mbbill/undotree'
	Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
	Plug 'nicwest/vim-camelsnek'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
" Text substitution
	Plug 'svermeulen/vim-subversive'
	Plug 'tpope/vim-abolish'
" Text splitting
	Plug 'AndrewRadev/splitjoin.vim'
	Plug 'sk1418/Join', {'on': 'Join'}
" Text objects
	Plug 'glts/vim-textobj-comment'
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
	Plug 'lambdalisue/fern.vim'
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
" Unix commands
	Plug 'tpope/vim-eunuch'
" Root directory
	Plug 'airblade/vim-rooter'
call plug#end()

" Misc keybinds
	let mapleader =","
	let maplocalleader = "\\"
	map U :redo<CR>
	map Y y$
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
" Buffers
	nmap <leader>bn :bn<CR>
	nmap <leader>bp :bp<CR>
	nmap <leader>bd :bd<CR>
	nnoremap gj <C-^>
" Tabs
	nmap g[ :-tabmove<CR>
	nmap g] :+tabmove<CR>
	nmap g^ :tabm 0<CR>
	nmap g$ :tabm<CR>
	nmap bD :tabclose!<CR>
	nnoremap <leader><space> :ToggleOnly<Enter>
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
" Splits
	" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitright splitbelow

	map <C-s> <C-w>S
	map <C-v> <C-w>v
	map <C-q> <C-w>q
	" map <C-h> <C-w>h
	" map <C-j> <C-w>j
	" map <C-k> <C-w>k
	" map <C-l> <C-w>l
	nnoremap <C-u> <C-w>w
	" Open alternative file in split
	map <c-t> :vs#<CR>
" Lens
	" let g:lens#disabled_filetypes = ['coc-explorer', 'nerdtree', 'fzf']
" Theme
	set bg=dark
	set termguicolors
	let g:rainbow_active = 1
" Color theme
	colorscheme jellybeans
	" colorscheme equinusocio_material

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
" Statusline
	function! NearestMethodOrFunction() abort
		return get(b:, 'vista_nearest_method_or_function', '')
	endfunction

	function! GitBlame() abort
		let blame = get(b:, 'coc_git_blame', '')
		" return blame
		return winwidth(0) > 120 ? blame : ''
	endfunction

	" Use auocmd to force lightline update.
	autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

	set noshowmode
	let g:lightline = {
		\ 'colorscheme': 'powerline',
		\ 'active': {
		\ 	'left': [
		\ 		[ 'mode', 'paste' ],
		\ 		[ 'readonly', 'filename', 'modified' ],
		\ 		[ 'diagnostic', 'cocstatus' ],
		\ 	],
		\ 	'right': [
		\ 		['lineinfo', 'percent' ],
		\     	[ 'blame', 'filetype' ],
		\ 	],
		\ },
		\ 'component_function': {
		\ 	'blame': 'GitBlame',
		\ 	'cocstatus': 'coc#status',
		\ 	'gitbranch': 'FugitiveHead',
		\ 	'vistamethod': 'NearestMethodOrFunction',
		\ },
		\ }
" Text
	set encoding=utf-8
	set tabstop=4
	set shiftwidth=4
	set whichwrap+=<,>,h,l,[,]
	syntax on
	set updatetime=200
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
" Search
	set ignorecase
	set incsearch
	set hlsearch
	set ignorecase smartcase
	set inccommand=nosplit
	nmap <silent> <space>/ :nohl<cr>
" Rendering
	set lazyredraw
" Filetype
	filetype plugin indent on
	set suffixesadd=.md
" Clipboard
	set clipboard+=unnamedplus
	set go=a
" Vim yoink
	nmap <m-]> <plug>(YoinkPostPasteSwapBack)
	nmap <m-[> <plug>(YoinkPostPasteSwapForward)

	nmap y <plug>(YoinkYankPreserveCursorPosition)
	xmap y <plug>(YoinkYankPreserveCursorPosition)

	nmap p <plug>(YoinkPaste_p)
	nmap P <plug>(YoinkPaste_P)

	nmap [y <plug>(YoinkRotateBack)
	nmap ]y <plug>(YoinkRotateForward)

	nmap <c-=> <plug>(YoinkPostPasteToggleFormat)
" Vim swap
	omap i, <Plug>(swap-textobject-i)
	xmap i, <Plug>(swap-textobject-i)
	omap a, <Plug>(swap-textobject-a)
	xmap a, <Plug>(swap-textobject-a)
" Vim subversive
	nmap s <plug>(SubversiveSubstitute)
	nmap ss <plug>(SubversiveSubstituteLine)
	nmap sl <plug>(SubversiveSubstituteToEndOfLine)

	xmap s <plug>(SubversiveSubstitute)
	xmap p <plug>(SubversiveSubstitute)
	xmap P <plug>(SubversiveSubstitute)

	nmap <leader><leader>s <plug>(SubversiveSubvertRange)
	xmap <leader><leader>s <plug>(SubversiveSubvertRange)
	nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

	nmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)
	xmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)
	nmap <leader>css <plug>(SubversiveSubstituteWordRangeConfirm)

	" ie = inner entire buffer
	onoremap ie :exec "normal! ggVG"<cr>
	" iv = current viewable text in the buffer
	onoremap iv :exec "normal! HVL"<cr>
" Replace all is aliased to S.
	nnoremap S :%s//<Left>
" Vim sneak
	" map f <Plug>Sneak_s
	" map F <Plug>Sneak_S
	" map f <Plug>Sneak_f
	" map F <Plug>Sneak_F
	" map t <Plug>Sneak_t
	" map T <Plug>Sneak_T
" Quick-scope
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" Aerojump
	nmap <Leader>as <Plug>(AerojumpSpace)
	nmap <Leader>ab <Plug>(AerojumpBolt)
	nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
	nmap <Leader>ad <Plug>(AerojumpDefault) " Boring mode
	nmap <space><space> <Plug>(AerojumpSpace)

	let g:aerojump_keymaps = { "<Esc>": "AerojumpExit" }
" Disables automatic commenting on newline:
	" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Terminal
	tnoremap <C-q> <C-\><C-n>:q<CR>
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
" Iron.nvim REPL
	luafile $HOME/.config/nvim/plugins.lua
	nmap <leader>it  :IronRepl python<CR><ESC>
	nmap <leader>if  :IronFocus python<CR>
	nmap <leader>ir  :IronRestart<CR>
	nmap <leader>iw  :IronWatchCurrentFile
	nmap <leader>iu  :IronUnwatchCurrentFile<CR>

	nmap <localleader>t    <Plug>(iron-send-motion)
	vmap <localleader>v    <Plug>(iron-visual-send)
	nmap <localleader>r    <Plug>(iron-repeat-cmd)
	nmap <localleader>l    <Plug>(iron-send-line)
	nmap <localleader><CR> <Plug>(iron-cr)
	nmap <localleader>i    <plug>(iron-interrupt)
	nmap <localleader>q    <Plug>(iron-exit)
	nmap <localleader>c    <Plug>(iron-clear)
" Vim-wiki
	" let g:vimwiki_list = [ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'} ]
" Vimspector
    nmap <leader>dd <Plug>VimspectorContinue
    nmap <leader>ds <Plug>VimspectorStop
    nmap <leader>dr <Plug>VimspectorRestart
    nmap <leader>dp <Plug>VimspectorPause
    nmap gb <Plug>VimspectorToggleBreakpoint
    nmap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
    nmap <leader>df <Plug>VimspectorAddFunctionBreakpoint
    nmap gn <Plug>VimspectorStepOver
    nmap gi <Plug>VimspectorStepInto
    nmap go <Plug>VimspectorStepOut
" Vim-test
	nmap <silent> <leader>tn :TestNearest<CR>
	nmap <silent> <leader>tf :TestFile<CR>
	nmap <silent> <leader>ts :TestSuite<CR>
	nmap <silent> <leader>tl :TestLast<CR>
	nmap <silent> <leader>tg :TestVisit<CR>
" fzf
	let g:fzf_tags_command = 'ctags -R'

	nmap <leader>ff  :Files<CR>
	nmap <leader>fb  :Buffers<CR>
	nmap <leader>fgc :Commits<CR>
	nmap <leader>fgf :GFiles<CR>
	nmap <leader>fgs :GFiles?<CR>
	nmap <leader>fl  :Lines<CR>
	nmap <leader>f/  :Rg
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
" Clap
	let g:clap_layout = { 'relative': 'editor' }

	nmap <leader>cf  :Clap files<CR>
	nmap <leader>cb  :Clap buffers<CR>
	nmap <leader>cgc :Clap commits<CR>
	nmap <leader>cgf :Clap git_files<CR>
	nmap <leader>cgd :Clap git_diff_files<CR>
	nmap <leader>cl  :Clap lines<CR>
	nmap <leader>c/  :Clap grep<CR>
	nmap <leader>cm  :Clap marks<CR>
	nmap <leader>ct  :Clap tags coc<CR>
	nmap <leader>cc  :Clap hist:<CR>
	nmap <leader>cs  :Clap hist/<CR>
	nmap <leader>ch  :Clap history<CR>
	nmap <leader>cw  :Clap windows<CR>
	nmap <leader>cj  :Clap jumps<CR>
	nmap <leader>cq  :Clap quickfix<CR>
	nmap <leader>cr  :Clap registers<CR>
	nmap <leader>cy  :Clap yanks<CR>
	nmap <leader>ce  :Clap filer<CR>
	nmap <leader>cp  :Clap providers<CR>
" Far.vim
	let g:far#source = 'rgnvim'

	" shortcut for far.vim find
	nnoremap <silent> <leader>rf  :Farf<cr>
	vnoremap <silent> <leader>rf  :Farf<cr>

	" shortcut for far.vim replace
	nnoremap <silent> <leader>rr  :Farr<cr>
	vnoremap <silent> <leader>rr  :Farr<cr>
" Ctrlsf
	let g:ctrlsf_regex_pattern = 1
	let g:ctrlsf_auto_focus = { "at": "done", "duration_less_than": 5000 }
	let g:ctrlsf_default_root = 'project'
	let g:ctrlsf_search_mode = 'async'
	let g:ctrlsf_position = 'right'
    let g:ctrlsf_mapping = { "vsplit": "<C-v>" }

	nmap     <leader>jj <Plug>CtrlSFPrompt
	vmap     <leader>jJ <Plug>CtrlSFVwordPath
	vmap     <leader>jj <Plug>CtrlSFVwordExec
	nmap     <leader>jn <Plug>CtrlSFCwordPath
	nmap     <leader>jp <Plug>CtrlSFPwordPath
	nnoremap <leader>jo :CtrlSFOpen<CR>
	nnoremap <leader>jt :CtrlSFToggle<CR>
	inoremap <leader>jt <Esc>:CtrlSFToggle<CR>
" Git
	let g:blamer_delay = 250

	map <leader>gb :Git blame<CR>
	map <leader>gc :Git commit
	map <leader>gd :Git diff<CR>
	map <leader>gg :Git<CR>
	map <leader>gl :Git log<CR>
	map <leader>gs :Gitdiffsplit<CR>
	map <leader>gt :Flog<CR>
	map <leader>gB :BlamerToggle<CR>
" Signify
	map <leader>vl :SignifyList<CR>
	map <leader>vd :SignifyDiff<CR>
	map <leader>vf :SignifyFold<CR>
	map <leader>vv :SignifyHunkDiff<CR>
	map <leader>vu :SignifyHunkUndo<CR>
	map <leader>vr :SignifyRefresh<CR>
	map <leader>vt :SignifyToggle<CR>
	map <leader>vh :SignifyToggleHighlight<CR>

	" Text objects
	omap ig <Plug>(signify-motion-inner-pending)
	xmap ig <Plug>(signify-motion-inner-visual)
	omap ag <Plug>(signify-motion-outer-pending)
	xmap ag <Plug>(signify-motion-outer-visual)

	" Highlight
    highlight SignifySignDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred
    highlight SignifyLineDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred
" Plug commands
	command! PU PlugUpdate | PlugUpgrade
" Vim-which-key
	nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Undotree
	nnoremap <leader>u :UndotreeToggle<CR>
" Vim-camelsnek
	map <leader>xs :Snek<CR>
	map <leader>xc :Camel<CR>
	map <leader>xb :CamelB<CR>
	map <leader>xk :Kebab<CR>
" AsyncTasks
	" Height of quick fix window
	let g:asyncrun_open = 12
" Markdown preview
	" set to 1, nvim will open the preview window after entering the markdown buffer
	" default: 0
	let g:mkdp_auto_start = 0

	" set to 1, the nvim will auto close current preview window when change
	" from markdown buffer to another buffer
	" default: 1
	let g:mkdp_auto_close = 1

	" set to 1, the vim will refresh markdown when save the buffer or
	" leave from insert mode, default 0 is auto refresh markdown as you edit or
	" move the cursor
	" default: 0
	let g:mkdp_refresh_slow = 0

	" set to 1, the MarkdownPreview command can be use for all files,
	" by default it can be use in markdown file
	" default: 0
	let g:mkdp_command_for_global = 0

	" set to 1, preview server available to others in your network
	" by default, the server listens on localhost (127.0.0.1)
	" default: 0
	let g:mkdp_open_to_the_world = 0

	" use custom IP to open preview page
	" useful when you work in remote vim and preview on local browser
	" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
	" default empty
	let g:mkdp_open_ip = ''

	" specify browser to open preview page
	" default: ''
	let g:mkdp_browser = ''

	" set to 1, echo preview page url in command line when open preview page
	" default is 0
	let g:mkdp_echo_preview_url = 0

	" a custom vim function name to open preview page
	" this function will receive url as param
	" default is empty
	let g:mkdp_browserfunc = ''

	" options for markdown render
	" mkit: markdown-it options for render
	" katex: katex options for math
	" uml: markdown-it-plantuml options
	" maid: mermaid options
	" disable_sync_scroll: if disable sync scroll, default 0
	" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
	"   middle: mean the cursor position alway show at the middle of the preview page
	"   top: mean the vim top viewport alway show at the top of the preview page
	"   relative: mean the cursor position alway show at the relative positon of the preview page
	" hide_yaml_meta: if hide yaml metadata, default is 1
	" sequence_diagrams: js-sequence-diagrams options
	let g:mkdp_preview_options = {
		\ 'mkit': {},
		\ 'katex': {},
		\ 'uml': {},
		\ 'maid': {},
		\ 'disable_sync_scroll': 0,
		\ 'sync_scroll_type': 'middle',
		\ 'hide_yaml_meta': 1,
		\ 'sequence_diagrams': {},
		\ 'flowchart_diagrams': {}
		\ }

	" use a custom markdown style must be absolute path
	" like '/Users/username/markdown.css' or expand('~/markdown.css')
	let g:mkdp_markdown_css = ''

	" use a custom highlight style must absolute path
	" like '/Users/username/highlight.css' or expand('~/highlight.css')
	let g:mkdp_highlight_css = ''

	" use a custom port to start server or random for empty
	let g:mkdp_port = ''

	" preview page title
	" ${name} will be replace with the file name
	let g:mkdp_page_title = '「${name}」'

	" keybinds
	nmap <leader>Mp <Plug>MarkdownPreview
	nmap <leader>Ms <Plug>MarkdownPreviewStop
	nmap <leader>Mt <Plug>MarkdownPreviewToggle
" Vista
" 	" How each level is indented and what to prepend.
" 	" This could make the display more compact or more spacious.
" 	" e.g., more compact: ["▸ ", ""]
" 	" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
" 	let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" 	" Executive used when opening vista sidebar without specifying it.
" 	" See all the avaliable executives via `:echo g:vista#executives`.
" 	let g:vista_default_executive = 'ctags'

" 	" Set the executive for some filetypes explicitly. Use the explicit executive
" 	" instead of the default one for these filetypes when using `:Vista` without
" 	" specifying the executive.
" 	let g:vista_executive_for = {
" 	  \ 'cpp': 'coc',
" 	  \ 'python': 'coc',
" 	  \ }

" 	" Declare the command including the executable and options used to generate ctags output
" 	" for some certain filetypes.The file path will be appened to your custom command.
" 	" For example:
" 	let g:vista_ctags_cmd = {
" 		  \ 'haskell': 'hasktags -x -o - -c',
" 		  \ }

" 	" To enable fzf's preview window set g:vista_fzf_preview.
" 	" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" 	" For example:
" 	let g:vista_fzf_preview = ['right:50%']

" 	" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
" 	let g:vista#renderer#enable_icon = 1

" 	" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
" 	let g:vista#renderer#icons = {
" 		\ "function": "\uf794",
" 		\ "variable": "\uf71b" }

" 	" Keybinds
" 	nmap <leader>Tt :Vista!!<CR>
" 	nmap <leader>Tf :Vista finder<CR>
" 	nmap <leader>Tr :Vista finder!<CR>
" 	nmap <leader>Tc :Vista toc<CR>
" 	nmap <leader>Tj :Vista focus<CR>
" 	nmap <leader>Ti :Vista info<CR>
" coc
	" Extensions
	let g:coc_global_extensions = [
		\ 'coc-actions',
		\ 'coc-cmake',
		\ 'coc-clangd',
		\ 'coc-emoji',
		\ 'coc-explorer',
		\ 'coc-floaterm',
		\ 'coc-highlight',
		\ 'coc-json',
		\ 'coc-markdownlint',
		\ 'coc-pairs',
		\ 'coc-pyright',
		\ 'coc-python',
		\ 'coc-rust-analyzer',
		\ 'coc-snippets',
		\ 'coc-tabnine',
		\ 'coc-vimlsp',
		\ 'coc-word',
		\ 'coc-yaml',
		\ 'coc-yank' ]

	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=1

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	if has('patch8.1.1068')
		" Use `complete_info` if your (Neo)Vim version supports it.
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
		imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	"Snippets
	" Use <C-l> for trigger snippet expand.
	imap <C-l> <Plug>(coc-snippets-expand)
	" Use <C-j> for select text for visual placeholder of snippet.
	vmap <C-j> <Plug>(coc-snippets-select)
	" Use <C-j> for jump to next placeholder, it's default of coc.nvim
	let g:coc_snippet_next = '<c-j>'
	" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
	let g:coc_snippet_prev = '<c-k>'
	" Use <C-j> for both expand and jump (make expand higher priority.)
	imap <C-j> <Plug>(coc-snippets-expand-jump)

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gp <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nmap <silent> gl <Plug>(coc-codelense-action)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	" autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>F   <Plug>(coc-format-selected)
	nmap <leader>F   <Plug>(coc-format)
	nmap <leader>ps  :CocCommand python.sortImports<CR>

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>A  <Plug>(coc-codeaction-selected)
	nmap <leader>A  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current line.
	nmap <leader>Ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)

	" Use <TAB> for selections ranges.
	" NOTE: Requires 'textDocument/selectionRange' support from the language server.
	" coc-tsserver, coc-python are the examples of servers that support it.
	nmap <silent> <leader><TAB> <Plug>(coc-range-select)
	xmap <silent> <leader><TAB> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent> <space>o  :<C-u>CocList --auto-preview outline<cr>
	" Search workspace symbols.
	nnoremap <silent> <space>s  :<C-u>CocList --interactive --auto-preview symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent> <space>l  :<C-u>CocListResume<CR>
	" Open coc config.
	nnoremap <silent> <space>f  :<C-u>CocConfig<CR>
	" coc-explorer
	nmap <silent> <leader>ef :CocCommand explorer --no-toggle<CR>
	nmap <silent> <leader>ee :CocCommand explorer<CR>
	" coc-yank
	nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<CR>
" Auto format
	let g:formatters_python = ['black']
	noremap <silent> <leader>F :Autoformat<cr>
" Semshi
	nmap <silent> <leader>rn :Semshi rename<CR>

	nmap <silent> <space><Tab> :Semshi goto name next<CR>
	nmap <silent> <space><S-Tab> :Semshi goto name prev<CR>

	nmap <silent> <space>c :Semshi goto class next<CR>
	nmap <silent> <space>C :Semshi goto class prev<CR>

	nmap <silent> <space>f :Semshi goto function next<CR>
	nmap <silent> <space>F :Semshi goto function prev<CR>

	nmap <silent> <space>gu :Semshi goto unresolved first<CR>
	nmap <silent> <space>gp :Semshi goto parameterUnused first<CR>

	nmap <silent> <space>ee :Semshi error<CR>
	nmap <silent> <space>ge :Semshi goto error<CR>
" Nvim-LSP
" lua << EOF
" 	require'nvim_lsp'.bashls.setup{}
" 	require'nvim_lsp'.ccls.setup{}
" 	require'nvim_lsp'.dockerls.setup{}
" 	require'nvim_lsp'.jsonls.setup{}
" 	require'nvim_lsp'.pyls_ms.setup{}
" 	-- require'nvim_lsp'.rls.setup{}
" 	require'nvim_lsp'.rust_analyzer.setup{}
" 	-- require'nvim_lsp'.sumneko_lua.setup{}
" 	require'nvim_lsp'.vimls.setup{}
" EOF

" 	" Keybinds
" 	imap <c-j> <cmd>lua require'source'.prevCompletion()<CR>
" 	imap <c-k> <cmd>lua require'source'.nextCompletion()<CR>

" 	nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
" 	nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
" 	nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" 	nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
" 	nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" 	nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" 	nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" 	nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" 	" Diagnostic signs
" 	sign define LspDiagnosticsErrorSign text=e
" 	sign define LspDiagnosticsWarningSign text=w
" 	sign define LspDiagnosticsInformationSign text=i
" 	sign define LspDiagnosticsHintSign text=.

" 	" Completion
" 	autocmd BufEnter * lua require'completion'.on_attach()
" 	let g:completion_auto_change_source = 1
" 	let g:completion_max_items = 25
" 	let g:completion_chain_complete_list = [
" 		\{'complete_items': ['lsp', 'snippet']},
" 		\{'mode': '<c-p>'},
" 	\]

" 	" Use <Tab> and <S-Tab> to navigate through popup menu
" 	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" 	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" 	" Set completeopt to have a better completion experience
" 	set completeopt=menuone,noinsert,noselect

" 	" Avoid showing message extra message when using completion
" 	set shortmess+=c
