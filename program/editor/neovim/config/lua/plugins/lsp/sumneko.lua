return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    local sumneko_root_path = "/Users/lgtf/just-build/sumneko-lua-lsp/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
    local luadev = require("lua-dev").setup({
      lspconfig = {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        on_attach = on_attach,
        root_dir = root_patterns,
        flags = { debounce_text_changes = debounce_text_changes },
        settings = {
          Lua = {
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
              maxPreload = 1000,
              preloadFileSize = 1000,
            },
          },
        },
      },
    })
    local lspconfig = require("lspconfig")
    lspconfig.sumneko_lua.setup(luadev)
  end,
}
