" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)
" Sort
	xnoremap <leader>s :sort<CR>
" Vim swap
	omap i, <Plug>(swap-textobject-i)
	xmap i, <Plug>(swap-textobject-i)
	omap a, <Plug>(swap-textobject-a)
	xmap a, <Plug>(swap-textobject-a)
" Vim switch
	let g:switch_mapping = "-"
" Vim subversive
	nmap s <plug>(SubversiveSubstitute)
	nmap ss <plug>(SubversiveSubstituteLine)
	nmap sl <plug>(SubversiveSubstituteToEndOfLine)

	xmap s <plug>(SubversiveSubstitute)
	xmap p <plug>(SubversiveSubstitute)
	xmap P <plug>(SubversiveSubstitute)

	nmap <leader><leader>s <plug>(SubversiveSubvertRange)
	xmap <leader><leader>s <plug>(SubversiveSubvertRange)
	nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

	nmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)
	xmap <leader>cs <plug>(SubversiveSubstituteRangeConfirm)
	nmap <leader>css <plug>(SubversiveSubstituteWordRangeConfirm)

	" ie = inner entire buffer
	onoremap ie :exec "normal! ggVG"<cr>
	" iv = current viewable text in the buffer
	onoremap iv :exec "normal! HVL"<cr>
" Wordmotion
let g:wordmotion_mappings = {
	\ 'w' : '<M-w>',
	\ 'b' : '<M-b>',
	\ 'e' : '<M-e>',
	\ 'ge' : 'g<M-e>',
	\ 'aw' : 'a<M-w>',
	\ 'iw' : 'i<M-w>',
	\ '<C-R><C-W>' : '<C-R><M-w>'
\ }
" Vim-camelsnek
	map <leader>xs :Snek<CR>
	map <leader>xc :Camel<CR>
	map <leader>xb :CamelB<CR>
	map <leader>xk :Kebab<CR>
