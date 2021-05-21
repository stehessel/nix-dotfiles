return {
  setup = function(on_attach, root_patterns)
    require("lspconfig").jsonls.setup({
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
          end,
        },
      },
      on_attach = on_attach,
      root_dir = root_patterns,
    })
  end,
}
