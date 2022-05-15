return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").ansiblels.setup({
      cmd = { "node", "/Users/lgtf/programs/ansible-language-server/out/server/src/server.js", "--stdio" },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
