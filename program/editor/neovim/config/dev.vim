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
" Vimspector
	" nnoremap <leader>dd <Plug>VimspectorContinue
	" nnoremap <leader>ds <Plug>VimspectorStop
	" nnoremap <leader>dr <Plug>VimspectorRestart
	" nnoremap <leader>dp <Plug>VimspectorPause
	" nnoremap gb <Plug>VimspectorToggleBreakpoint
	" nnoremap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
	" nnoremap <leader>df <Plug>VimspectorAddFunctionBreakpoint
	" nnoremap <CR> <Plug>VimspectorStepOver
	" nnoremap <S-CR> <Plug>VimspectorStepInto
	" nnoremap <BS> <Plug>VimspectorStepOut

	let g:vimspector_enable_mappings = 'HUMAN'
	let g:vimspector_install_gadgets = [ 'debugpy', 'CodeLLDB' ]
	let g:vimspector_sidebar_width = 60
	let g:vimspector_code_minwidth = 100
	let g:vimspector_terminal_minwidth = 80
" Vim-test
	let test#python#runner = "pytest"
	let test#strategy = "neoterm"

	nnoremap <silent> <leader>tn :TestNearest<CR>
	nnoremap <silent> <leader>tf :TestFile<CR>
	nnoremap <silent> <leader>ts :TestSuite<CR>
	nnoremap <silent> <leader>tl :TestLast<CR>
	nnoremap <silent> <leader>tg :TestVisit<CR>

	" Transformations
	function! DockerPythonTransform(cmd) abort
		let container_id = system("docker ps --filter 'name=raq' --quiet")
		" return 'docker exec -it '.container_id.' bash -l -c '.shellescape("cd /Users/lgtf/git/raq && ".a:cmd)
		let port = 6000
		return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m debugpy --listen 0.0.0.0:'.port.' --wait-for-client -m '.a:cmd
	endfunction

	let g:test#custom_transformations = {'docker-python': function('DockerPythonTransform')}

	" Raq test execution
	augroup raq_tests
		autocmd!
		autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#transformation = "docker-python"'
	augroup END
