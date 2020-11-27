require("vimp")
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Compatibility with vi
vim.o.compatible = false
-- Line breaks
vim.o.linebreak = true
vim.o.breakindent = true
-- Sessions
vim.cmd("set sessionoptions+=tabpages,globals,winpos,winsize,blank,resize")
-- do not store global and local values in a session
vim.cmd("set sessionoptions-=options")
-- do not store folds
vim.cmd("set sessionoptions-=folds")
-- Yank whole buffer
vimp.nnoremap({"silent"}, "<leader>Y", ":%y<cr>")
-- Select whole buffer
vimp.nnoremap({"silent"}, "<leader>V", "ggVG")
-- Delete whole buffer
vimp.nnoremap({"silent"}, "<leader>D", ":%d<cr>")
-- Visual mode
vimp.nnoremap({"silent"}, "<M-v>", "<C-v>")
-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
-- Disable highlight
vimp.nnoremap({"silent"}, "<space>/", ":nohl<cr>")

vim.g.grep_params = " --files --ignore-case --hidden -g '!.git' -g '!*/__pycache__/*' -g '!*.pyc'"
-- Replace all is aliased to S.
vimp.nnoremap({"silent"}, "S", ":%s//<left>")
vimp.xnoremap({"silent"}, "S", ":s//<Left>")
-- Buffers
vimp.nnoremap({"silent"}, "<leader>bn", ":bn<cr>")
vimp.nnoremap({"silent"}, "<leader>bp", ":bp<cr>")
vimp.nnoremap({"silent"}, "<leader>bd", ":bd<cr>")
-- Open alternative file
vimp.nnoremap({"silent"}, "gj", "<C-^>")
-- Open alternative file in split
vimp.nnoremap({"silent"}, "gk", ":vs#<cr>")
-- Tabs
vimp.nnoremap({"silent"}, "g[", ":-tabmove<cr>")
vimp.nnoremap({"silent"}, "g]", ":+tabmove<cr>")
vimp.nnoremap({"silent"}, "g^", ":tabm 0<cr>")
vimp.nnoremap({"silent"}, "g$", ":tabm<cr>")
vimp.nnoremap({"silent"}, "<C-t>", ":tabnew<cr>")
vimp.nnoremap({"silent"}, "<leader><space>", ":ToggleOnly<enter>")
-- Splits
-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.o.splitright = true

vimp.nnoremap({"silent"}, "<C-s>", "<C-w>S")
vimp.nnoremap({"silent"}, "<C-v>", "<C-w>v")
vimp.nnoremap({"silent"}, "<C-q>", "<C-w>q")
vimp.nnoremap({"silent"}, "<C-m>", "<C-w>w")
-- Quickfix
vimp.nnoremap({"silent"}, "<leader>co", ":copen<cr>")
vimp.nnoremap({"silent"}, "<leader>cc", ":cclose<cr>")
vimp.nnoremap({"silent"}, "<leader>cw", ":cw<cr>")
vimp.nnoremap({"silent"}, "<leader>cn", ":cn<cr>")
vimp.nnoremap({"silent"}, "<leader>cp", ":cp<cr>")
vim.cmd([[nnoremap <expr> <cr> &buftype ==# "quickfix" ? "\<cr>" : "za"]])
-- Reloading
vim.o.autoread = true
-- Trigger `autoread` when files changes on disk
vim.cmd(
    [[autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]]
)
-- Notification after file change
vim.cmd(
    [[autocmd FileChangedShellPost *
		\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
)
-- Lens
-- vim.g["lens#disabled_filetypes"] = ['coc-explorer', 'nerdtree', 'fzf']
-- Theme
vim.o.bg = "dark"
vim.o.termguicolors = true
-- Highlighters
vim.cmd("highlight HighlightedyankRegion cterm=reverse gui=reverse")
vim.cmd("highlight CursorColumn cterm=reverse gui=reverse")
vim.cmd("highlight CursorLine cterm=reverse gui=reverse")
-- Text
vim.o.encoding = "utf-8"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.cmd("set whichwrap+=<,>,h,l,[,]")
vim.cmd("syntax on")
vim.o.updatetime = 100
vim.o.foldenable = false
-- Title
vim.o.title = true
-- Line numbers
vim.o.number = true
vimp.nnoremap(
    {"silent"},
    "<leader>N",
    function()
        vim.wo.number = not vim.wo.number
    end
)
-- Undo
vim.o.undofile = true
vim.o.undodir = "~/.config/nvim/undo"
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
-- Spell-check set to <leader>o, 'o' for 'orthography':
vim.cmd("map <leader>o :setlocal spell! spelllang=en_us<CR>")
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
vim.g.node_host_prog = "$HOME/.nix-profile/bin/npm"
-- Perl
vim.g.loaded_perl_provider = 0
-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "$HOME/miniconda3/bin/python"
-- Pycln
vimp.nnoremap({"silent"}, "<leader>I", ":AsyncRun pycln %<cr>")
-- Sort
vimp.xnoremap({"silent"}, "<leader>s", ":sort<cr>")
-- Terminal navigation
vimp.tnoremap({"silent"}, "<C-q>", [[<C-\><C-n>:q<cr>]])
vimp.tnoremap({"silent"}, "<C-h>", [[<C-\><C-n><C-w>h]])
vimp.tnoremap({"silent"}, "<C-j>", [[<C-\><C-n><C-w>j]])
vimp.tnoremap({"silent"}, "<C-k>", [[<C-\><C-n><C-w>k]])
vimp.tnoremap({"silent"}, "<C-l>", [[<C-\><C-n><C-w>l]])
