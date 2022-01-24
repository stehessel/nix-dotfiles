local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.fn.sign_define("LspDiagnosticsSignError", { text = " ", texthl = "LspDiagnosticsSignError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ", texthl = "LspDiagnosticsSignWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ", texthl = "LspDiagnosticsSignInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint", { text = " ", texthl = "LspDiagnosticsSignHint" })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      source = "always",
    },
    severity_sort = true,
  })

  -- Mappings
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr })

  if client.resolved_capabilities.hover then
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
  end
  vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, { buffer = bufnr })
  if client.resolved_capabilities.rename then
    vim.keymap.set("n", "<Space>r", vim.lsp.buf.rename, { buffer = bufnr })
  end

  vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
  vim.keymap.set("n", "<Space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr })

  vim.keymap.set("n", "<Space>d", function()
    vim.diagnostic.open_float(0, { focusable = false, scope = "line" })
  end, { buffer = bufnr })
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ float = { focusable = false } })
  end)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ float = { focusable = false } })
  end)

  vim.keymap.set("n", "<Space>f", vim.lsp.buf.formatting_sync, { buffer = bufnr })

  -- Callstack
  vim.keymap.set("n", "<Space>ci", vim.lsp.buf.incoming_calls, { buffer = bufnr })
  vim.keymap.set("n", "<Space>co", vim.lsp.buf.outgoing_calls, { buffer = bufnr })
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local root_patterns = require("lspconfig").util.root_pattern(".git", ".root")

local servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "gopls",
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
  require("plugins.lsp." .. name).setup(on_attach, capabilities, root_patterns, 150)
end

return { on_attach = on_attach }