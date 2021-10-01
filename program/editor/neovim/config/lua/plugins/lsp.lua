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
    vimp.nnoremap({ "override", "silent" }, "<space>a", vim.lsp.buf.code_action)
    vimp.xnoremap({ "override", "silent" }, "<space>a", vim.lsp.buf.range_code_action)

    vimp.nnoremap({ "override", "silent" }, "<space>wa", vim.lsp.buf.add_workspace_folder)
    vimp.nnoremap({ "override", "silent" }, "<space>wr", vim.lsp.buf.remove_workspace_folder)
    vimp.nnoremap({ "override", "silent" }, "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)

    vimp.nnoremap({ "override", "silent" }, "<space>d", function()
      vim.diagnostic.show_line_diagnostics({ focusable = false })
    end)
    vimp.nnoremap({ "override", "silent" }, "[d", function()
      vim.diagnostic.goto_prev({ popup_opts = { focusable = false } })
    end)
    vimp.nnoremap({ "override", "silent" }, "]d", function()
      vim.diagnostic.goto_next({ popup_opts = { focusable = false } })
    end)

    if client.resolved_capabilities.document_formatting then
      vimp.nnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.formatting)
    elseif client.resolved_capabilities.document_range_formatting then
      vimp.vnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.range_formatting)
    end
  end)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
local root_patterns = require("lspconfig").util.root_pattern(".git", ".root")

local servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "jsonls",
  "null-ls",
  "pyright",
  "rnix",
  -- "sqls",
  "sumneko",
  "tailwindcss",
  "tsserver",
  "yamlls",
}
for _, name in ipairs(servers) do
  require("plugins.lsp." .. name).setup(on_attach, capabilities, root_patterns, 500)
end
