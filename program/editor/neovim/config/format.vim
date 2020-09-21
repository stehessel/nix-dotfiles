" Neoformat
	" Format on save
	augroup format
		autocmd!
		autocmd BufWritePre *.lua,*.py,*.sql undojoin | Neoformat
	augroup END

	let g:neoformat_enabled_lua = ['luafmt']
	let g:neoformat_enabled_python = ['black']
	let g:neoformat_enabled_sql = ['pg_format']
	let g:neoformat_enabled_yaml = ['prettier']
	nnoremap <leader>F :Neoformat<CR>
