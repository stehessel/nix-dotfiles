return {
  setup = function(on_attach, flags)
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").lua_ls.setup({
      cmd = { "lua-language-server" },
      on_attach = on_attach,
      flags = flags,
      settings = {
        Lua = {
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
          format = {
            enable = false,
          },
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
