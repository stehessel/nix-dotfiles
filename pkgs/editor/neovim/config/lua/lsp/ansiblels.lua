return {
  setup = function(on_attach, flags)
    require("lspconfig").ansiblels.setup({
      cmd = { "node", "/Users/lgtf/programs/ansible-language-server/out/server/src/server.js", "--stdio" },
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
