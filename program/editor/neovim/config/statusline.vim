" Statusline
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
		\ },
		\ }

