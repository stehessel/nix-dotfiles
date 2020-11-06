" Search
	set ignorecase
	set incsearch
	set hlsearch
	set ignorecase smartcase
	set inccommand=nosplit
	nmap <silent> <space>/ :nohl<cr>

	let g:grep_params = " --files --ignore-case --hidden -g '!.git' -g '!*/__pycache__/*' -g '!*.pyc'"
" Replace all is aliased to S.
	nnoremap S :%s//<Left>
	xnoremap S :s//<Left>
" Fzf
	function! g:FzfFilesSource()
	    let l:base = fnamemodify(expand('%'), ':h:.:S')
	    let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'

	    if base == '.'
		return "rg" . g:grep_params
	    else
		return printf("rg" . g:grep_params . " | %s %s", l:proximity_sort_path, expand('%'))
	    endif
	endfunction

	let g:fzf_tags_command = 'ctags -R'

	nmap <silent> <leader>ff  :call fzf#vim#files('', {'source': g:FzfFilesSource(), 'options': ['--info=inline', '--preview', 'bat --color=always --style=numbers {}']})<CR>
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
