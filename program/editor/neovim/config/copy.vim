" Clipboard
	set clipboard+=unnamedplus
	set go=a
" Vim yoink
	nmap <m-]> <plug>(YoinkPostPasteSwapBack)
	nmap <m-[> <plug>(YoinkPostPasteSwapForward)

	nmap y <plug>(YoinkYankPreserveCursorPosition)
	xmap y <plug>(YoinkYankPreserveCursorPosition)

	nmap p <plug>(YoinkPaste_p)
	nmap P <plug>(YoinkPaste_P)

	nmap [y <plug>(YoinkRotateBack)
	nmap ]y <plug>(YoinkRotateForward)

	nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

