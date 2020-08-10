" Search
	set ignorecase
	set incsearch
	set hlsearch
	set ignorecase smartcase
	set inccommand=nosplit
	nmap <silent> <space>/ :nohl<cr>
" Replace all is aliased to S.
	nnoremap S :%s//<Left>
" Fzf
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
	nmap <leader>cgb :Clap bcommits<CR>
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
" Aerojump
	nmap <Leader>as <Plug>(AerojumpSpace)
	nmap <Leader>ab <Plug>(AerojumpBolt)
	nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
	nmap <Leader>ad <Plug>(AerojumpDefault) " Boring mode
	nmap <space>j <Plug>(AerojumpSpace)

	let g:aerojump_keymaps = { "<Esc>": "AerojumpExit" }
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
