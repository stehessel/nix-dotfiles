" Plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'bling/vim-airline'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-slash'
Plug 'kovetskiy/sxhkd-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
call plug#end()

" General settings

" Commands
command! PU PlugUpdate | PlugUpgrade

" Keybinds
let mapleader =","
map U :redo<CR>
nnoremap <silent> <C-l> :<C-u>nohl<CR><C-l>
noremap <plug>(slash-after) zz

" Theme
	set bg=dark
	colorscheme jellybeans
	set termguicolors
" Text
	set encoding=utf-8
	set number relativenumber
	set whichwrap+=<,>,h,l,[,]
	syntax on
" Clipboard
	set clipboard+=unnamedplus
	set go=a
" Mouse
	set mouse=a
" Search
	set nohlsearch
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
" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright
" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" vimling:
	nm <leader>d :call ToggleDeadKeys()<CR>
	imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader>i :call ToggleIPA()<CR>
	imap <leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader>q :call ToggleProse()<CR>
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
