" Git
	let g:blamer_delay = 250

	map <leader>gb :Git blame<CR>
	map <leader>gc :Git commit
	map <leader>gd :Git diff<CR>
	map <leader>gg :Git<CR>
	map <leader>gl :Git log<CR>
	map <leader>gs :Gitdiffsplit<CR>
	map <leader>gt :Flog<CR>
	map <leader>gB :BlamerToggle<CR>
" Signify
	map <leader>vl :SignifyList<CR>
	map <leader>vd :SignifyDiff<CR>
	map <leader>vf :SignifyFold<CR>
	map <leader>vv :SignifyHunkDiff<CR>
	map <leader>vu :SignifyHunkUndo<CR>
	map <leader>vr :SignifyRefresh<CR>
	map <leader>vt :SignifyToggle<CR>
	map <leader>vh :SignifyToggleHighlight<CR>

	" Text objects
	omap ig <Plug>(signify-motion-inner-pending)
	xmap ig <Plug>(signify-motion-inner-visual)
	omap ag <Plug>(signify-motion-outer-pending)
	xmap ag <Plug>(signify-motion-outer-visual)

	" Highlight
    highlight SignifySignDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred
    highlight SignifyLineDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred
