return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").ansiblels.setup({
      cmd = { "node", "/Users/lgtf/programs/ansible-language-server/out/server/src/server.js", "--stdio" },
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
