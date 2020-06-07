" Auto format
	" augroup autoformat_settings
	" 	autocmd FileType python AutoFormatBuffer black
	" 	autocmd FileType rust AutoFormatBuffer rustfmt
	" augroup END
	nnoremap <leader>F :FormatCode<CR>
	vnoremap <leader>F :FormatLines<CR>
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
	let test#strategy = "neoterm"

	nmap <silent> <leader>tn :TestNearest<CR>
	nmap <silent> <leader>tf :TestFile<CR>
	nmap <silent> <leader>ts :TestSuite<CR>
	nmap <silent> <leader>tl :TestLast<CR>
	nmap <silent> <leader>tg :TestVisit<CR>
