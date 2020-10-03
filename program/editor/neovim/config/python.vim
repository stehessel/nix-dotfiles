" Pycln
	nnoremap <leader>I :AsyncRun pycln %<CR>
" Rope
	let ropevim_local_prefix = "<M-r>"
	let ropevim_global_prefix = "<M-p>"
	let g:ropevim_autoimport_modules = ["*"]
	let g:ropevim_enable_autoimport = 1
	let g:ropevim_guess_project = 1

	nmap <M-,> :call RopeCodeAssist()<CR>
	nmap <M-.> :call RopeLuckyAssist()<CR>
	nmap <M-CR> :call RopeAutoImport()<CR>
	nmap <M-d> :call RopeGotoDefinition()<CR>
" Semshi
	nmap <silent> <leader>rn :Semshi rename<CR>

	nmap <silent> <space><Tab> :Semshi goto name next<CR>
	nmap <silent> <space><S-Tab> :Semshi goto name prev<CR>

	nmap <silent> <space>k :Semshi goto class next<CR>
	nmap <silent> <space>K :Semshi goto class prev<CR>

	nmap <silent> <space>f :Semshi goto function next<CR>
	nmap <silent> <space>F :Semshi goto function prev<CR>

	nmap <silent> <space>gu :Semshi goto unresolved first<CR>
	nmap <silent> <space>gp :Semshi goto parameterUnused first<CR>

	nmap <silent> <space>ee :Semshi error<CR>
	nmap <silent> <space>ge :Semshi goto error<CR>
