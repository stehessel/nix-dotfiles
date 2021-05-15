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
  elseif client.resolved_capabilities.document_range_formatting then
    vimp.vnoremap({"override", "silent"}, "<space>f", vim.lsp.buf.range_formatting)
  end
end

local root_patterns = nvim_lsp.util.root_pattern(".git", ".root")

nvim_lsp.bashls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.dockerls.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.efm.setup({
  init_options = {documentFormatting = true},
  on_attach = on_attach,
  root_dir = root_patterns,
  settings = {
    rootMarkers = {".git/", ".root"},
    languages = {
      css = {require("plugins.efm.prettier")},
      dockerfile = {require("plugins.efm.hadolint")},
      html = {require("plugins.efm.prettier")},
      json = {require("plugins.efm.prettier"), require("plugins.efm.spectral")},
      jsonc = {require("plugins.efm.prettier"), require("plugins.efm.spectral")},
      lua = {require("plugins.efm.lua-format")},
      markdown = {require("plugins.efm.prettier")},
      python = {
        require("plugins.efm.black"),
        require("plugins.efm.flake8"),
        require("plugins.efm.isort"),
      },
      scss = {require("plugins.efm.prettier")},
      sh = {require("plugins.efm.shellcheck"), require("plugins.efm.shfmt")},
      sql = {require("plugins.efm.pg-format")},
      yaml = {require("plugins.efm.prettier")},
    },
  },
})

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

if not nvim_lsp.sourcery then
  require("lspconfig/configs").sourcery = {
    default_config = {
      cmd = {"/Users/lgtf/miniconda3/bin/sourcery", "lsp"},
      filetypes = {"python"},
      init_options = {
        token = "user_n80vzPEXsMA5mzvpZ25FPpNqbMGX_F_V696MKkMbrQtU9B7ZFj390TX8_GI",
        extension_version = "neovim",
        editor_version = "vim",
      },
      settings = {
        sourcery = {
          token = "user_n80vzPEXsMA5mzvpZ25FPpNqbMGX_F_V696MKkMbrQtU9B7ZFj390TX8_GI",
          metricsEnabled = true,
        },
      },
    },
  }
end
nvim_lsp.sourcery.setup({on_attach = on_attach, root_dir = root_patterns})

nvim_lsp.sqls.setup({
  on_attach = function(client)
    on_attach(client)
    client.resolved_capabilities.execute_command = true
    require"sqls".setup({picker = "telescope"})
  end,
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
