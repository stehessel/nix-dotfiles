return {
  setup = function(on_attach, flags)
    vim.lsp.config("nixd", {
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
