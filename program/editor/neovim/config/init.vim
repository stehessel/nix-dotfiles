" Plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')
" Git
	Plug 'airblade/vim-gitgutter'
	Plug 'jreybert/vimagit'
	Plug 'tpope/vim-fugitive'
	Plug 'rhysd/git-messenger.vim'
" Fuzzy finder
	Plug 'dyng/ctrlsf.vim'
	Plug '/home/stephan/.nix-profile/bin/fzf'
	Plug 'junegunn/fzf' ", { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
" Statusline
	" Plug 'bling/vim-airline'
	Plug 'itchyny/lightline.vim'
" LSP
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'liuchengxu/vista.vim'
" Auto complete
	" Plug 'ncm2/ncm2'
	" Plug 'ncm2/ncm2-path'
	" Plug 'roxma/nvim-yarp'
" Debugger
	Plug 'vim-vdebug/vdebug'
	Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
" Code folding
	" Plug 'kalekundert/vim-coiled-snake'
	Plug 'Konfekt/FastFold'
	Plug 'tmhedberg/SimpylFold'
" Syntax highlighting
	Plug 'kovetskiy/sxhkd-vim'
	Plug 'LnL7/vim-nix'
" REPL
	Plug 'metakirby5/codi.vim'
" Markdown preview
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" Docker
" Theme
	Plug 'nanotech/jellybeans.vim'
" Brackets
	Plug 'adelarsq/vim-matchit'
	" Plug 'cohama/lexima.vim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'luochen1990/rainbow'
	Plug 'tpope/vim-surround'
" Text manipulation
	Plug 'easymotion/vim-easymotion'
	Plug 'junegunn/vim-easy-align'
	Plug 'mbbill/undotree'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-repeat'
" Buffers
	Plug 'jlanzarotta/bufexplorer'
" File viewer
	Plug 'ryanoasis/vim-devicons'
	Plug 'scrooloose/nerdtree'
" Search
	Plug 'pgdouyon/vim-evanesco'
" Focus mode
	Plug 'junegunn/goyo.vim'
" Copy/paste
	Plug 'machakann/vim-highlightedyank'
" Discover keybinds
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
" Save position
	Plug 'farmergreg/vim-lastplace'
" Note taking
	Plug 'vimwiki/vimwiki'
" Dispatcher
	Plug 'tpope/vim-dispatch'
call plug#end()

" Misc keybinds
	let mapleader =","
	map U :redo<CR>
	map Y y$
	nnoremap <silent> <C-l> :<C-u>nohl<CR><C-l>
	noremap <plug>(slash-after) zz
" Split keybinds:
	map <C-s> <C-w>S
	map <C-v> <C-w>v
	map <C-q> <C-w>q
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" Theme
	set bg=dark
	colorscheme jellybeans
	set termguicolors
	let g:rainbow_active = 1
" Highlighters
	highlight HighlightedyankRegion cterm=reverse gui=reverse
" Statusline
	let g:lightline = {
		\ 'colorscheme': 'powerline',
		\ 'active': {
		\ 	'left': [ [ 'mode', 'paste' ],
		\ 		[ 'gitbranch', 'readonly', 'relativepath', 'modified' ], [ 'cocstatus' ] ]
		\ },
		\ 'component_function': {
		\ 	'cocstatus': 'coc#status',
		\ 	'gitbranch': 'FugitiveHead'
		\ },
		\ }
" Text
	set encoding=utf-8
	set tabstop=4
	set shiftwidth=4
	set number relativenumber
	set whichwrap+=<,>,h,l,[,]
	syntax on
	set updatetime=100
	set nofoldenable
" Clipboard
	set clipboard+=unnamedplus
	set go=a
" Mouse
	set mouse=a
" Search
	set ignorecase
	set incsearch
	set nohlsearch
	set smartcase
" Filetype
	filetype plugin indent on
" Enable autocompletion:
	" set wildmode=longest,list,full
	" " enable ncm2 for all buffers
	" autocmd BufEnter * call ncm2#enable_for_buffer()
	" " set completeopt to be what ncm2 expects
	" set completeopt=noinsert,menuone,noselect
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" plug commands
	command! PU PlugUpdate | PlugUpgrade
" Vim-which-key
	nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
" coc
	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

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

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	autocmd SourceCmd *plugin/evanesco.vim source <afile> | nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

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
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder.
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current line.
	nmap <leader>ac  <Plug>(coc-codeaction)
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
	nmap <silent> <TAB> <Plug>(coc-range-select)
	xmap <silent> <TAB> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
	nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" fzf mappings
	map <leader>ff :Files<CR>
	map <leader>fg :GFiles?<CR>
	map <leader>fb :Buffers<CR>
	map <leader>fl :Lines<CR>
	map <leader>fm :Marks<CR>
	map <leader>ft :Tags<CR>
	map <leader>fw :Tags<CR>
	map <leader>fh :History<CR>
	map <leader>fh :Filetypes<CR>
	" Insert mode completion
	imap <c-x><c-k> <plug>(fzf-complete-word)
	imap <c-x><c-f> <plug>(fzf-complete-path)
	imap <c-x><c-j> <plug>(fzf-complete-file)
	imap <c-x><c-l> <plug>(fzf-complete-line)
	" Advanced customization using Vim function
	inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" Ctrlsf
	let g:ctrlsf_regex_pattern = 1
	let g:ctrlsf_auto_focus = { "at": "done", "duration_less_than": 1000 }
	let g:ctrlsf_default_root = 'project'
	let g:ctrlsf_search_mode = 'async'
	let g:ctrlsf_position = 'right'

	nmap     <C-F>f <Plug>CtrlSFPrompt
	vmap     <C-F>f <Plug>CtrlSFVwordPath
	vmap     <C-F>F <Plug>CtrlSFVwordExec
	nmap     <C-F>n <Plug>CtrlSFCwordPath
	nmap     <C-F>p <Plug>CtrlSFPwordPath
	nnoremap <C-F>o :CtrlSFOpen<CR>
	nnoremap <C-F>t :CtrlSFToggle<CR>
	inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" Git
	map <leader>gb :Git blame<CR>
	map <leader>gc :Git commit
	map <leader>gd :Git diff<CR>
	map <leader>gg :Git<CR>
	map <leader>gl :Git log<CR>
	map <leader>gs :Gitdiffsplit<CR>
" Goyo plugin makes text more readable when writing prose:
	map <leader>p :Goyo \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitright splitbelow
" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)
" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Undotree
	nnoremap <leader>u :UndotreeToggle<CR>
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
	nmap <leader>mp <Plug>MarkdownPreview
	nmap <leader>ms <Plug>MarkdownPreviewStop
	nmap <leader>mt <Plug>MarkdownPreviewToggle
