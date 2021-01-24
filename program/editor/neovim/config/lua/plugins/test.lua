vim.g["test#python#runner"] = "pytest"
vim.g["test#python#pytest#options#"] = {["all"] = "--capture=no"}
vim.g["test#strategy"] = "neoterm"

require("vimp")
vimp.nnoremap({"silent"}, "<leader>tn", ":TestNearest<cr>")
vimp.nnoremap({"silent"}, "<leader>tf", ":TestFile<cr>")
vimp.nnoremap({"silent"}, "<leader>ts", ":TestSuite<cr>")
vimp.nnoremap({"silent"}, "<leader>tl", ":TestLast<cr>")
vimp.nnoremap({"silent"}, "<leader>tg", ":TestVisit<cr>")
vimp.nnoremap({"silent"}, "<leader>tr", function()
  vim.g["test#transformation"] = "pytest-run"
end)
vimp.nnoremap({"silent"}, "<leader>td", function()
  vim.g["test#transformation"] = "pytest-debug"
end)

vim.api.nvim_exec([[
		function! PytestDebugTransform(cmd) abort
			let container_id = trim(system("docker ps --filter 'name=raq' --quiet"))
			let port = 6000
			let res = system('docker exec '.container_id.' pkill python')
			return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m debugpy --listen 0.0.0.0:'.port.' --wait-for-client -m '.a:cmd
		endfunction

		function! PytestRunTransform(cmd) abort
			let container_id = trim(system("docker ps --filter 'name=raq' --quiet"))
			return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m '.a:cmd
		endfunction

		let g:test#custom_transformations = {'pytest-debug': function('PytestDebugTransform'), 'pytest-run': function('PytestRunTransform')}
	]], false)

vim.cmd [[augroup raq_tests]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#transformation = "pytest-debug"']]
vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#project_root = "$HOME/git/raq"']]
vim.cmd [[augroup END]]
