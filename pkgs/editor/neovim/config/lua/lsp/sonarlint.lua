return {
  setup = function(on_attach, flags)
    if not require("lspconfig").sonarlint then
      require("lspconfig/configs").sonarlint = {
        default_config = { cmd = { "nc", "-l", "6008" }, filetypes = { "python" } },
      }
    end
    require("lspconfig").sonarlint.setup({
      on_attach = on_attach,
      flags = flags,
    })
  end,
}
