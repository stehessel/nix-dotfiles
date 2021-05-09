local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  vimp.nnoremap({"override", "silent"}, "gD", vim.lsp.buf.declaration)
  vimp.nnoremap({"override", "silent"}, "gy", vim.lsp.buf.implementation)
  if client.resolved_capabilities.find_references then
    vimp.nnoremap({"override", "silent"}, "gr", vim.lsp.buf.references)
  end
  vimp.nnoremap({"override", "silent"}, "gh", "<cmd>Lspsaga lsp_finder<CR>")
  vimp.nnoremap({"override", "silent"}, "gK", "<cmd>Lspsaga signature_help<CR>")

  if client.resolved_capabilities.hover then
    vimp.nnoremap({"override", "silent"}, "K", "<cmd>Lspsaga hover_doc<CR>")
  end
  vimp.nnoremap({"override", "silent"}, "<space>p", "<cmd>Lspsaga preview_definition<CR>")
  vimp.nnoremap({"override", "silent"}, "<space>D", vim.lsp.buf.type_definition)
  if client.resolved_capabilities.rename then
    vimp.nnoremap({"override", "silent"}, "<space>r", "<cmd>Lspsaga rename<CR>")
  end
  vimp.nnoremap({"override", "silent"}, "<space>a", "<cmd>Lspsaga code_action<CR>")
  vimp.xnoremap({"override", "silent"}, "<space>a", "<cmd>Lspsaga range_code_action<CR>")

  vimp.nnoremap({"override", "silent"}, "<space>wa", vim.lsp.buf.add_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wr", vim.lsp.buf.remove_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)

  vimp.nnoremap({"override", "silent"}, "<space>d",
    "<cmd>Lspsaga show_line_diagnostics<CR>")
  vimp.nnoremap({"override", "silent"}, "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  vimp.nnoremap({"override", "silent"}, "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  if client.resolved_capabilities.document_formatting then
    vimp.nnoremap({"override", "silent"}, "<space>f", vim.lsp.buf.formatting)
    vim.api.nvim_exec([[
      augroup Format
        autocmd!
        autocmd BufWritePost *.lua lua vim.lsp.buf.formatting()
      augroup END
    ]], true)
  elseif client.resolved_capabilities.document_range_formatting then
    vimp.vnoremap({"override", "silent"}, "<space>f", vim.lsp.buf.range_formatting)
  end
end

local root_patterns = nvim_lsp.util.root_pattern(".root", ".git")

nvim_lsp.bashls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.efm.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.dockerls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.jsonls.setup({
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
      end,
    },
  },
  on_attach = on_attach,
  root_dir = root_patterns,
})

nvim_lsp.rnix.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.pyright.setup({
  on_attach = on_attach,
  root_dir = root_patterns,
  settings = {
    python = {analysis = {typeCheckingMode = "off", useLibraryCodeForTypes = false}},
  },
})

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
        globals = {
          -- Neovim
          "vim",
          -- packer
          "use",
          "packer_plugins",
          -- Busted
          "after_each",
          "before_each",
          "describe",
          "it",
          "pending",
          "teardown",
          -- vimpeccable
          "vimp",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 1000,
        preloadFileSize = 1000,
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
