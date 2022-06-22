return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").sumneko_lua.setup({
      cmd = { "lua-language-server" },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            globals = {
              -- Neovim
              "vim",
              -- packer
              "cmp",
              "use",
              "packer_plugins",
              -- Busted
              "after_each",
              "before_each",
              "describe",
              "it",
              "pending",
              "teardown",
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
