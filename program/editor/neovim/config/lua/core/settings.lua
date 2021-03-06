-- Compatibility with vi
vim.o.compatible = false

vim.o.shell = "bash"
vim.cmd("let $SHELL = 'bash'")

-- Set hidden buffers
vim.o.hidden = true

-- Line breaks
vim.o.linebreak = true
vim.o.breakindent = true

-- Sessions
vim.cmd("set sessionoptions+=tabpages,globals,winpos,winsize,blank,resize")
-- do not store global and local values in a session
vim.cmd("set sessionoptions-=options")
-- do not store folds
vim.cmd("set sessionoptions-=folds")

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.g.grep_params =
  " --files --ignore-case --hidden -g '!.git' -g '!*/__pycache__/*' -g '!*.pyc'"
-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.o.splitright = true
vim.o.splitbelow = true

-- Reloading
vim.o.autoread = true
-- Trigger `autoread` when files changes on disk
vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]])
-- Notification after file change
vim.cmd([[autocmd FileChangedShellPost *
		\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])

-- Lens
-- vim.g["lens#disabled_filetypes"] = ['coc-explorer', 'nerdtree', 'fzf']

-- Text
vim.o.encoding = "utf-8"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd("set whichwrap+=<,>,h,l,[,]")
vim.cmd("syntax on")
vim.o.updatetime = 100

-- Folds
vim.o.foldlevelstart = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Title
vim.o.title = true

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Undo
vim.bo.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- Mouse
vim.o.mouse = "a"

-- Rendering
vim.o.lazyredraw = true

-- Filetype
vim.cmd("filetype plugin indent on")
vim.o.suffixesadd = ".md"
-- Disables automatic commenting on newline:
-- autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

-- Vim-wiki
-- let g:vimwiki_list = [ {'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'} ]

-- Automatically deletes all trailing whitespace on save.
vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])
-- Update binds when sxhkdrc is updated.
vim.cmd([[autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd]])
-- Save file as sudo on files that require root permission
vim.cmd([[cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]])

-- Clipboard
vim.cmd("set clipboard+=unnamedplus")
vim.cmd("set go=a")

-- Javescript
vim.g.loaded_node_provider = 0
vim.g.node_host_prog = os.getenv("HOME")
                         .. "/.npm-packages/lib/node_modules/neovim/bin/cli.js"
-- Perl
vim.g.loaded_perl_provider = 0
-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = os.getenv("HOME") .. "/miniconda3/bin/python"
-- Ruby
vim.g.loaded_ruby_provider = 0
