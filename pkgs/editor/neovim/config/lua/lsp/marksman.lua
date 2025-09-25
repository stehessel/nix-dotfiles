return {
  setup = function(on_attach, flags)
    vim.lsp.config("marksman", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
