vim.g["test#python#runner"] = "pytest"
vim.g["test#python#pytest#options#"] = {["all"] = "--capture=no"}
vim.g["test#strategy"] = "neoterm"

require("vimp")
vimp.nnoremap({"silent"}, "<leader>tn", ":TestNearest<cr>")
vimp.nnoremap({"silent"}, "<leader>tf", ":TestFile<cr>")
vimp.nnoremap({"silent"}, "<leader>ts", ":TestSuite<cr>")
vimp.nnoremap({"silent"}, "<leader>tl", ":TestLast<cr>")
vimp.nnoremap({"silent"}, "<leader>tg", ":TestVisit<cr>")
vimp.nnoremap("<leader>tr", function()
  print("Test stragegy set to 'docker-pytest-run'")
  vim.g["test#transformation"] = "docker-pytest-run"
end)
vimp.nnoremap("<leader>tR", function()
  print("Test stragegy set to 'pytest-run'")
  vim.g["test#transformation"] = nil
end)
vimp.nnoremap("<leader>td", function()
  print("Test stragegy set to 'docker-pytest-debug'")
  vim.g["test#transformation"] = "docker-pytest-debug"
end)

vim.api.nvim_exec([[
		function! DockerPytestDebugTransform(cmd) abort
			let container_id = trim(system("docker ps --filter 'name=raq' --quiet"))
			let port = 6000
			let res = system('docker exec '.container_id.' pkill python')
			return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m debugpy --listen 0.0.0.0:'.port.' --wait-for-client -m '.a:cmd
		endfunction

		function! DockerPytestRunTransform(cmd) abort
			let container_id = trim(system("docker ps --filter 'name=raq' --quiet"))
			return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m '.a:cmd
		endfunction

		function! PytestDebug(cmd)
			let test = join(split(a:cmd, " ")[1:], " ")
			call vimspector#LaunchWithSettings(#{Test: test})
		endfunction

		let g:test#custom_transformations = { "docker-pytest-debug": function("DockerPytestDebugTransform"), "docker-pytest-run": function("DockerPytestRunTransform") }
		let g:test#custom_strategies = {"debug": function("PytestDebug")}
		let g:test#strategy = "debug"
	]], false)

vim.cmd [[augroup raq_tests]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#transformation = "docker-pytest-debug"']]
vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#project_root = "$HOME/git/raq"']]
vim.cmd [[augroup END]]
