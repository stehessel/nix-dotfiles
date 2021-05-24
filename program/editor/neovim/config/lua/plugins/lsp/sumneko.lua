return {
  setup = function(on_attach, root_patterns)
    local sumneko_root_path = "/Users/lgtf/just-build/sumneko-lua-lsp/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

    require("lspconfig").sumneko_lua.setup({
      on_attach = on_attach,
      root_dir = root_patterns,
      cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
  end,
}
