" Auto format
	" augroup fmt
	" 	autocmd!
	" 	autocmd BufWritePre * undojoin | Neoformat
	" augroup END
	let g:neoformat_enabled_python = ['black']
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
