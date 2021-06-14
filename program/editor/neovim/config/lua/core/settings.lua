-- Compatibility with vi
vim.opt.compatible = false

vim.opt.shell = "bash"
vim.cmd("let $SHELL = 'bash'")

-- Set hidden buffers
vim.opt.hidden = true

-- Line breaks
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Sessions
vim.opt.sessionoptions:append({ "tabpages", "globals", "winpos", "winsize", "blank", "resize" })
-- do not store folds
-- do not store global and local values in a session
vim.opt.sessionoptions:remove({ "folds", "options" })

-- Sign column
vim.opt.signcolumn = "yes"

-- Short messages
vim.opt.shortmess:append("c")
-- Cmd height
vim.opt.cmdheight = 2

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.g.grep_params = " --files --ignore-case --hidden -g '!.git' -g '!*/__pycache__/*' -g '!*.pyc'"

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Reloading
vim.opt.autoread = true
-- Trigger `autoread` when files changes on disk
-- vim.cmd([[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
--		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]])
-- Notification after file change
-- vim.cmd([[autocmd FileChangedShellPost *
--		\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]])

-- Text
vim.opt.encoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true, ["["] = true, ["]"] = true })
vim.opt.updatetime = 200

-- Folds
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Title
vim.opt.title = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- Mouse
vim.opt.mouse = "a"

-- Rendering
vim.opt.lazyredraw = true

-- Highlight yank
vim.api.nvim_exec(
  [[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]],
  false
)

-- Filetype
vim.opt.suffixesadd = ".md"

-- Automatically deletes all trailing whitespace on save.
vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])
-- Update binds when sxhkdrc is updated.
vim.cmd([[autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd]])
-- Save file as sudo on files that require root permission
vim.cmd([[cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!]])

-- Clipboard
vim.opt.clipboard = { "unnamedplus" }

-- Javescript
-- vim.g.loaded_node_provider = 0
vim.g.node_host_prog = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/neovim/bin/cli.js"
-- Perl
vim.g.loaded_perl_provider = 0
-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = os.getenv("HOME") .. "/miniconda3/bin/python"
-- Ruby
vim.g.loaded_ruby_provider = 0
