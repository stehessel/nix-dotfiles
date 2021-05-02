local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts)
  buf_set_keymap("n", "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e",
    "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

local root_patterns = nvim_lsp.util.root_pattern(".root", ".git")

nvim_lsp.bashls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.efm.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.dockerls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.jsonls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.rnix.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.pyright.setup({on_attach = on_attach, root_dir = root_patterns})

local sumneko_root_path = "/Users/lgtf/just-build/sumneko-lua-lsp/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
nvim_lsp.sumneko_lua.setup({
  on_attach = on_attach,
  root_dir = root_patterns,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"use", "vim", "vimp"},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

nvim_lsp.sqls.setup {
  on_attach = function(client)
    on_attach(client)
    client.resolved_capabilities.execute_command = true
    require"sqls".setup({picker = "telescope"})
  end,
}

nvim_lsp.yamlls.setup({
  on_attach = on_attach,
  root_dir = root_patterns,
  settings = {
    yaml = {
      schemas = {
        ["/Users/lgtf/git/sc-deploy/deploy/schemas/core-data-snapshotter/schema.json"] = {
          "/core_data_snapshotter.yml",
        },
      },
    },
  },
})
