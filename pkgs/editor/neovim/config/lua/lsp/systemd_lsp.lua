return {
  setup = function(on_attach, flags)
    vim.lsp.config("systemd_lsp", {
      on_attach = on_attach,
      flags = flags,
    })

    -- Automatically set filetype and start LSP for systemd and Podman Quadlet unit files.
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = {
        -- systemd unit files
        "*.automount",
        "*.device",
        "*.mount",
        "*.path",
        "*.scope",
        "*.service",
        "*.slice",
        "*.socket",
        "*.swap",
        "*.target",
        "*.timer",
        -- Podman Quadlet files
        "*.build",
        "*.container",
        "*.image",
        "*.kube",
        "*.network",
        "*.pod",
        "*.volume",
      },
      callback = function()
        vim.bo.filetype = "systemd"
        vim.lsp.start({
          name = "systemd_lsp",
          cmd = { "systemd-lsp" },
          root_dir = vim.fn.getcwd(),
        })
      end,
    })
  end,
}
