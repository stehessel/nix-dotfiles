" Neoformat
	" Format on save
	augroup format
		autocmd!
		autocmd BufWritePre * undojoin | Neoformat
	augroup END

	let g:neoformat_enabled_python = ['black']
	let g:neoformat_enabled_sql = ['pg_format']
	nnoremap <leader>F :Neoformat<CR>
" Vimspector
    nnoremap <leader>dd <Plug>VimspectorContinue
    nnoremap <leader>ds <Plug>VimspectorStop
    nnoremap <leader>dr <Plug>VimspectorRestart
    nnoremap <leader>dp <Plug>VimspectorPause
    nnoremap gb <Plug>VimspectorToggleBreakpoint
    nnoremap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
    nnoremap <leader>df <Plug>VimspectorAddFunctionBreakpoint
    nnoremap <CR> <Plug>VimspectorStepOver
    nnoremap <S-CR> <Plug>VimspectorStepInto
    nnoremap <BS> <Plug>VimspectorStepOut
" Vim-test
	let test#python#runner = "pytest"
	let test#strategy = "neoterm"

	nnoremap <silent> <leader>tn :TestNearest<CR>
	nnoremap <silent> <leader>tf :TestFile<CR>
	nnoremap <silent> <leader>ts :TestSuite<CR>
	nnoremap <silent> <leader>tl :TestLast<CR>
	nnoremap <silent> <leader>tg :TestVisit<CR>

	" Transformations
	function! DockerTransform(cmd) abort
		let container_id = system("docker ps --filter 'name=raq' --quiet")
		return 'docker exec -it '.container_id.' bash -l -c '.shellescape("cd /Users/lgtf/git/raq && ".a:cmd)
	endfunction

	let g:test#custom_transformations = {'docker': function('DockerTransform')}
	let g:test#transformation = 'docker'
