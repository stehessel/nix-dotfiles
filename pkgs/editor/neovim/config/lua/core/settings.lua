-- Compatibility with vi
vim.opt.compatible = false

-- Completion
vim.opt.completeopt = "menuone,noselect"

vim.opt.shell = "bash"
vim.cmd("let $SHELL = 'bash'")

-- Line breaks
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Scrolling
vim.opt.scrolloff = 5

-- Sessions
vim.opt.sessionoptions:append({ "tabpages", "globals", "winpos", "winsize", "blank", "resize" })
-- do not store folds, global and local values in a session
vim.opt.sessionoptions:remove({ "folds", "options" })

-- Sign column
vim.opt.signcolumn = "yes"

-- Diagnostics
vim.keymap.set("n", "<Space>D", function()
  vim.diagnostic.disable()
end)
vim.keymap.set("n", "<Space>d", function()
  vim.diagnostic.open_float(0, { focusable = false, scope = "line" })
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = { focusable = false } })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = { focusable = false } })
end)

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "",
      ["DapBreakpoint"] = "●",
      ["DapStopped"] = "▶",
    },
  },
  virtual_text = true,
})

-- Short messages
vim.opt.shortmess:append("c")
-- Cmd height
vim.opt.cmdheight = 1

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.grep_params = " --files --ignore-case --hidden -g '!.git' -g '!*/__pycache__/*' -g '!*.pyc'"

-- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Reloading
vim.opt.autoread = true

-- Text
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.whichwrap:append({ ["<"] = true, [">"] = true, h = true, l = true, ["["] = true, ["]"] = true })
vim.opt.updatetime = 750

-- Folds
vim.opt.foldlevelstart = 99

local function enable_foldexpr(bufnr)
  if vim.api.nvim_buf_line_count(bufnr) > 40000 then
    return
  end
  vim.api.nvim_buf_call(bufnr, function()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.cmd.normal("zx")
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    enable_foldexpr(args.buf)
  end,
})

-- Title
vim.opt.title = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"

-- Rendering
vim.opt.lazyredraw = true

-- Highlight yank
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  group = "highlight_yank",
})

-- Filetype
vim.opt.suffixesadd = ".md"

-- Set correct terraform file type
vim.api.nvim_create_augroup("terraform", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  callback = function()
    vim.o.filetype = "terraform"
  end,
  group = "terraform",
  pattern = "*.tf",
})

-- Automatically deletes all trailing whitespace on save.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  command = [[%s/\s\+$//e]],
})

-- Clipboard
vim.opt.clipboard = { "unnamedplus" }

-- Javescript
vim.g.loaded_node_provider = 0
-- vim.g.node_host_prog = os.getenv("HOME") .. "/.npm-packages/lib/node_modules/neovim/bin/cli.js"
-- Perl
vim.g.loaded_perl_provider = 0
-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = os.getenv("NVIM_PYTHON_PROVIDER")
-- Ruby
vim.g.loaded_ruby_provider = 0
