return {
  setup = function(on_attach, flags)
    vim.lsp.config("tailwindcss", {
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
