" Auto format
	" augroup fmt
	" 	autocmd!
	" 	autocmd BufWritePre * undojoin | Neoformat
	" augroup END
	let g:neoformat_enabled_python = ['black']
	nnoremap <leader>F :Neoformat<CR>
" Vimspector
    nmap <leader>dd <Plug>VimspectorContinue
    nmap <leader>ds <Plug>VimspectorStop
    nmap <leader>dr <Plug>VimspectorRestart
    nmap <leader>dp <Plug>VimspectorPause
    nmap gb <Plug>VimspectorToggleBreakpoint
    nmap <leader>dc <Plug>VimspectorToggleConditionalBreakpoint
    nmap <leader>df <Plug>VimspectorAddFunctionBreakpoint
    nmap gn <Plug>VimspectorStepOver
    nmap gi <Plug>VimspectorStepInto
    nmap go <Plug>VimspectorStepOut
" Vim-test
	let test#python#runner = "pytest"
	let test#strategy = "neoterm"

	nmap <silent> <leader>tn :TestNearest<CR>
	nmap <silent> <leader>tf :TestFile<CR>
	nmap <silent> <leader>ts :TestSuite<CR>
	nmap <silent> <leader>tl :TestLast<CR>
	nmap <silent> <leader>tg :TestVisit<CR>
