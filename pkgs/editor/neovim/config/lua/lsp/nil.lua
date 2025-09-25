return {
  setup = function(on_attach, flags)
    vim.lsp.config("nil_ls", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
