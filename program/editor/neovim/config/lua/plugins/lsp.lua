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
  vimp.nnoremap({"override", "silent"}, "gh", require("lspsaga.provider").lsp_finder)
  vimp.nnoremap({"override", "silent"}, "gK",
    require("lspsaga.signaturehelp").signature_help)

  if client.resolved_capabilities.hover then
    vimp.nnoremap({"override", "silent"}, "K", require("lspsaga.hover").render_hover_doc)
    vimp.nnoremap({"override", "silent"}, "<C-d>", function()
      require("lspsaga.action").smart_scroll_with_saga(1)
    end)
    vimp.nnoremap({"override", "silent"}, "<C-u>", function()
      require("lspsaga.action").smart_scroll_with_saga(-1)
    end)
  end
  vimp.nnoremap({"override", "silent"}, "<space>p",
    require"lspsaga.provider".preview_definition)
  vimp.nnoremap({"override", "silent"}, "<space>D", vim.lsp.buf.type_definition)
  if client.resolved_capabilities.rename then
    vimp.nnoremap({"override", "silent"}, "<space>r", require("lspsaga.rename").rename)
  end
  vimp.nnoremap({"override", "silent"}, "<space>a",
    require("lspsaga.codeaction").code_action)
  vimp.xnoremap({"override", "silent"}, "<space>a",
    require("lspsaga.codeaction").range_code_action)

  vimp.nnoremap({"override", "silent"}, "<space>wa", vim.lsp.buf.add_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wr", vim.lsp.buf.remove_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)

  vimp.nnoremap({"override", "silent"}, "<space>d",
    require("lspsaga.diagnostic").show_line_diagnostics)
  vimp.nnoremap({"override", "silent"}, "[d",
    require("lspsaga.diagnostic").lsp_jump_diagnostic_prev)
  vimp.nnoremap({"override", "silent"}, "]d",
    require("lspsaga.diagnostic").lsp_jump_diagnostic_next)

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
