return {
  setup = function(on_attach, flags)
    require("lspconfig").nixd.setup({
      on_attach = on_attach,
      flags = flags,
      settings = {
        formatting = {
          command = "alejandra",
        },
      },
    })
  end,
}
