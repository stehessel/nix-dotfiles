" Nvim-LSP
lua << EOF
	require'nvim_lsp'.bashls.setup{}
	require'nvim_lsp'.ccls.setup{}
	require'nvim_lsp'.dockerls.setup{}
	require'nvim_lsp'.jsonls.setup{}
	require'nvim_lsp'.pyls.setup{}
	-- require'nvim_lsp'.rls.setup{}
	require'nvim_lsp'.rust_analyzer.setup{}
	-- require'nvim_lsp'.sumneko_lua.setup{}
	require'nvim_lsp'.vimls.setup{}
EOF

" Keybinds
	imap <c-j> <cmd>lua require'source'.prevCompletion()<CR>
	imap <c-k> <cmd>lua require'source'.nextCompletion()<CR>

	nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" Diagnostic signs
	sign define LspDiagnosticsErrorSign text=e
	sign define LspDiagnosticsWarningSign text=w
	sign define LspDiagnosticsInformationSign text=i
	sign define LspDiagnosticsHintSign text=.

" Completion
	autocmd BufEnter * lua require'completion'.on_attach()
	autocmd BufEnter * lua require'diagnostic'.on_attach()
	let g:completion_auto_change_source = 1
	let g:completion_matching_ignore_case = 1
	let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
	let g:completion_chain_complete_list = [
		\ {'complete_items': ['lsp']},
		\ {'complete_items': ['path'], 'triggered_only': ['/']},
		\ {'complete_items': ['buffer']},
		\ {'complete_items': ['snippet']},
		\ {'mode' : ['<c-p>', 'file']}
	\]

" Use <Tab> and <S-Tab> to navigate through popup menu
	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
	set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
	set shortmess+=c
