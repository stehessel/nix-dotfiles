return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    local system_name
    if vim.fn.has("mac") == 1 then
      system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
      system_name = "Linux"
    elseif vim.fn.has("win32") == 1 then
      system_name = "Windows"
    else
      print("Unsupported system for sumneko")
    end

    local sumneko_root_path = "/Users/lgtf/just-build/sumneko-lua-lsp/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require("lspconfig").sumneko_lua.setup({
      cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
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
            maxPreload = 2000,
            preloadFileSize = 1000,
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
}
