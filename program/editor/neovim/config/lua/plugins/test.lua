vim.g["test#python#runner"] = "pytest"
vim.g["test#python#pytest#options#"] = {["all"] = "--capture=no"}
vim.g["test#strategy"] = "neoterm"

require("vimp")
vimp.nnoremap({"silent"}, "<leader>tn", ":TestNearest<cr>")
vimp.nnoremap({"silent"}, "<leader>tf", ":TestFile<cr>")
vimp.nnoremap({"silent"}, "<leader>ts", ":TestSuite<cr>")
vimp.nnoremap({"silent"}, "<leader>tl", ":TestLast<cr>")
vimp.nnoremap({"silent"}, "<leader>tg", ":TestVisit<cr>")

vim.api.nvim_exec(
    [[
		function! DockerPythonTransform(cmd) abort
			let container_id = system("docker ps --filter 'name=raq' --quiet")
			let port = 6000
			return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m debugpy --listen 0.0.0.0:'.port.' --wait-for-client -m '.a:cmd
		endfunction

		let g:test#custom_transformations = {'docker-python': function('DockerPythonTransform')}
	]],
    false
)

vim.cmd [[augroup raq_tests]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#transformation = "docker-python"']]
vim.cmd [[augroup END]]
