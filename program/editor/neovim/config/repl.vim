" Terminal navigation
	tnoremap <C-q> <C-\><C-n>:q<CR>
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
" Neoterm
	let g:neoterm_default_mod = "rightbelow"
	let g:neoterm_autoinsert = 1

	nnoremap <leader>Tt :vert Ttoggle<CR>
	nnoremap <leader>Tr :TREPLSetTerm<CR>
	nnoremap <leader>Tf :TREPLSendFile<CR>
	nnoremap <leader>Tl :TREPLSendLine<CR>
	vnoremap <leader>Tl :TREPLSendSelection<CR>
    " Use gx{text-object} in normal mode
    nmap gx <Plug>(neoterm-repl-send)
    " Send selected contents in visual mode.
    xmap gx <Plug>(neoterm-repl-send)

	nnoremap <leader>Tc :<c-u>exec v:count.'Tclear'<CR>
" Iron.nvim REPL
	luafile $HOME/.config/nvim/plugins.lua
	nmap <leader>it  :IronRepl python<CR><ESC>
	nmap <leader>if  :IronFocus python<CR>
	nmap <leader>ir  :IronRestart<CR>
	nmap <leader>iw  :IronWatchCurrentFile
	nmap <leader>iu  :IronUnwatchCurrentFile<CR>

	nmap <localleader>t    <Plug>(iron-send-motion)
	vmap <localleader>v    <Plug>(iron-visual-send)
	nmap <localleader>r    <Plug>(iron-repeat-cmd)
	nmap <localleader>l    <Plug>(iron-send-line)
	nmap <localleader><CR> <Plug>(iron-cr)
	nmap <localleader>i    <plug>(iron-interrupt)
	nmap <localleader>q    <Plug>(iron-exit)
	nmap <localleader>c    <Plug>(iron-clear)
