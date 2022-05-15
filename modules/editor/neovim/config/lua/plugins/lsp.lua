vim.keymap.set("n", "<Space>d", function()
  vim.diagnostic.open_float(0, { focusable = false, scope = "line" })
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = { focusable = false } })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = { focusable = false } })
end)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    source = "always",
  },
  severity_sort = true,
})

local on_attach = function(_, bufnr)
  -- Mappings
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, { buffer = bufnr })
  vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename, { buffer = bufnr })

  vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  vim.keymap.set("n", "<Space>f", function()
    vim.lsp.buf.format({ async = false })
  end, { buffer = bufnr })

  -- Callstack
  vim.keymap.set("n", "<Space>ci", vim.lsp.buf.incoming_calls, { buffer = bufnr })
  vim.keymap.set("n", "<Space>co", vim.lsp.buf.outgoing_calls, { buffer = bufnr })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "gopls",
  "groovyls",
  "jsonls",
  "pyright",
  "rnix",
  -- "sqls",
  "sumneko",
  "tailwindcss",
  "terraformls",
  "tsserver",
  "yamlls",
}
for _, name in ipairs(servers) do
  require("plugins.lsp." .. name).setup(on_attach, capabilities, 150)
end

return { on_attach = on_attach }
