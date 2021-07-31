return {
  setup = function(on_attach, root_patterns, debounce_text_changes)
    if not require("lspconfig")["ansible-ls"] then
      require("lspconfig/configs")["ansible-ls"] = {
        default_config = {},
      }
    end
    require("lspconfig")["ansible-ls"].setup({
      cmd = { "node", "/Users/lgtf/programs/ansible-language-server/out/server/src/server.js", "--stdio" },
      filetypes = { "yaml" },
      on_attach = on_attach,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
