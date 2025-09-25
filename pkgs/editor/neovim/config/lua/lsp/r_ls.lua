return {
  setup = function(on_attach, flags)
    vim.lsp.config("r_language_server", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
