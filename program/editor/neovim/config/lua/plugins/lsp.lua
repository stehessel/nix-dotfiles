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
  vimp.add_buffer_maps(bufnr, function()
    vimp.nnoremap({ "override", "silent" }, "gD", vim.lsp.buf.declaration)
    vimp.nnoremap({ "override", "silent" }, "gK", vim.lsp.buf.signature_help)

    if client.resolved_capabilities.hover then
      vimp.nnoremap({ "override", "silent" }, "K", vim.lsp.buf.hover)
    end
    vimp.nnoremap({ "override", "silent" }, "<space>D", vim.lsp.buf.type_definition)
    if client.resolved_capabilities.rename then
      vimp.nnoremap({ "override", "silent" }, "<space>r", vim.lsp.buf.rename)
    end

    vimp.nnoremap({ "override", "silent" }, "<space>wa", vim.lsp.buf.add_workspace_folder)
    vimp.nnoremap({ "override", "silent" }, "<space>wr", vim.lsp.buf.remove_workspace_folder)
    vimp.nnoremap({ "override", "silent" }, "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)

    vimp.nnoremap({ "override", "silent" }, "<space>d", function()
      vim.diagnostic.open_float(0, { focusable = false, scope = "line" })
    end)
    vimp.nnoremap({ "override", "silent" }, "[d", function()
      vim.diagnostic.goto_prev({ float = { focusable = false } })
    end)
    vimp.nnoremap({ "override", "silent" }, "]d", function()
      vim.diagnostic.goto_next({ float = { focusable = false } })
    end)

    if client.resolved_capabilities.document_formatting then
      vimp.nnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.formatting)
    elseif client.resolved_capabilities.document_range_formatting then
      vimp.vnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.range_formatting)
    end

    -- Callstack
    vimp.nnoremap({ "override", "silent" }, "<space>ci", vim.lsp.buf.incoming_calls)
    vimp.nnoremap({ "override", "silent" }, "<space>co", vim.lsp.buf.outgoing_calls)
  end)
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
  "null-ls",
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
  require("plugins.lsp." .. name).setup(on_attach, capabilities, root_patterns, 500)
end
