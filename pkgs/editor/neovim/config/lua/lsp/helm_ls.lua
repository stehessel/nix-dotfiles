return {
  setup = function(on_attach, flags)
    vim.lsp.config("helm_ls", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
