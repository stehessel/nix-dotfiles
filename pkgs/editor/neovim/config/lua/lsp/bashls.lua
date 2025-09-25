return {
  setup = function(on_attach, flags)
    vim.lsp.config("bashls", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
