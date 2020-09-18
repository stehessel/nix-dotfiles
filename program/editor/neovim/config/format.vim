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

" Formatter.nvim
" lua require('format').setup()
" nnoremap <silent> <leader>f :Format<CR>
" lua require('format').setup({
" 	lua = {
" 		luafmt = function()
" 			return {
"     			exe = "luafmt",
" 				args = {"--indent-count", 4, "--stdin"},
" 				stdin = true
" 			}
" 		end
" 	},
" 	python = {
" 		black = function()
" 			return {
"     			exe = "black",
" 				args = {},
" 				stdin = true
" 			}
" 		end
" 	},
" 	sql = {
" 		pg_format = function()
" 			return {
"     			exe = "pg_format",
" 				args = {},
" 				stdin = true
" 			}
" 		end
" 	},
" 	yaml = {
" 		prettier = function()
" 			return {
"     			exe = "prettier",
" 				args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
" 				stdin = true
" 			}
" 		end
" 	}
" })
