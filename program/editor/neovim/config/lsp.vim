" Nvim-LSP
lua << EOF
	require'nvim_lsp'.bashls.setup{}
	require'nvim_lsp'.ccls.setup{}
	require'nvim_lsp'.dockerls.setup{}
	require'nvim_lsp'.jsonls.setup{}
	require'nvim_lsp'.pyls_ms.setup{}
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
	let g:completion_auto_change_source = 1
	let g:completion_max_items = 25
	let g:completion_chain_complete_list = {
		\'default' : {
		\	'default' : [
		\		{ 'complete_items' : ['lsp', 'snippet'] },
		\		{ 'mode' : ['<c-p>', 'file'] }
		\	],
		\	'comment' : [],
		\	'string' : []
		\	},
		\'c' : [
		\	{'complete_items': ['ts']}
		\	],
		\'python' : [
		\	{'complete_items': ['ts']}
		\	],
		\'lua' : [
		\	{'complete_items': ['ts']}
		\	],
		\}

" Use <Tab> and <S-Tab> to navigate through popup menu
	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
	set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
	set shortmess+=c
