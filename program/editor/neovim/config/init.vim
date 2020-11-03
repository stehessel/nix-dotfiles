lua require('plugins')

" Misc keybinds
	let mapleader = ','
	let maplocalleader = '\\'
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
" Sessions
	set sessionoptions+=tabpages,globals,winpos,winsize,blank,resize
	" do not store global and local values in a session
	set sessionoptions-=options
	" do not store folds
	set sessionoptions-=folds
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
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Clipboard
	set clipboard+=unnamedplus
	set go=a
" Sources
	source ~/.config/nvim/coc.vim
	source ~/.config/nvim/dev.vim
	source ~/.config/nvim/git.vim
	" source ~/.config/nvim/linters.vim
	" source ~/.config/nvim/lsp.vim
	source ~/.config/nvim/providers.vim
	source ~/.config/nvim/python.vim
	source ~/.config/nvim/repl.vim
	source ~/.config/nvim/search.vim
	source ~/.config/nvim/statusline.vim
	source ~/.config/nvim/text.vim
