return {
  setup = function(on_attach, capabilities, root_patterns, debounce_text_changes)
    require("lspconfig").ansiblels.setup({
      cmd = { "node", "/Users/lgtf/programs/ansible-language-server/out/server/src/server.js", "--stdio" },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = root_patterns,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}