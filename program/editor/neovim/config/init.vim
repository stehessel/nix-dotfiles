" Plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')
Plug '/home/stephan/.nix-profile/bin/fzf'
Plug 'adelarsq/vim-matchit'
Plug 'airblade/vim-gitgutter'
" Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'farmergreg/vim-lastplace'
Plug 'itchyny/lightline.vim'
Plug 'jreybert/vimagit'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf' ", { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'
Plug 'kovetskiy/sxhkd-vim'
Plug 'liuchengxu/vista.vim'
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'nanotech/jellybeans.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'rhysd/git-messenger.vim'
Plug 'roxma/nvim-yarp'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
call plug#end()

" Keybinds
let mapleader =","
map U :redo<CR>
map Y y$
nnoremap <silent> <C-l> :<C-u>nohl<CR><C-l>
noremap <plug>(slash-after) zz

" Theme
	set bg=dark
	colorscheme jellybeans
	set termguicolors
	let g:rainbow_active = 1
" Statusline
	let g:lightline = {
		\ 'colorscheme': 'powerline',
		\ 'active': {
		\ 	'left': [ [ 'mode', 'paste' ],
		\ 		[ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
		\ },
		\ 'component_function': {
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
	set wildmode=longest,list,full
	" enable ncm2 for all buffers
	autocmd BufEnter * call ncm2#enable_for_buffer()
	" set completeopt to be what ncm2 expects
	set completeopt=noinsert,menuone,noselect
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" plug commands
	command! PU PlugUpdate | PlugUpgrade

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
" Goyo plugin makes text more readable when writing prose:
	map <leader>p :Goyo \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitright splitbelow
" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>
" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>
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
