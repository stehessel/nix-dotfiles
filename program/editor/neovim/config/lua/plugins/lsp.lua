local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.fn.sign_define("LspDiagnosticsSignError", { text = " ", texthl = "LspDiagnosticsSignError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ", texthl = "LspDiagnosticsSignWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ", texthl = "LspDiagnosticsSignInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint", { text = " ", texthl = "LspDiagnosticsSignHint" })

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

    vimp.nnoremap({ "override", "silent" }, "<space>d", vim.lsp.diagnostic.show_line_diagnostics)
    vimp.nnoremap({ "override", "silent" }, "[d", vim.lsp.diagnostic.goto_prev)
    vimp.nnoremap({ "override", "silent" }, "]d", vim.lsp.diagnostic.goto_next)

    if client.resolved_capabilities.document_formatting then
      vimp.nnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.formatting)
    elseif client.resolved_capabilities.document_range_formatting then
      vimp.vnoremap({ "override", "silent" }, "<space>f", vim.lsp.buf.range_formatting)
    end
  end)
end
local root_patterns = require("lspconfig").util.root_pattern(".git", ".root")

local servers = {
  "bashls",
  "dockerls",
  "efm",
  "jsonls",
  "pyright",
  "rnix",
  -- "sqls",
  "sumneko",
  "yamlls",
}
for _, name in ipairs(servers) do
  require("plugins.lsp." .. name).setup(on_attach, root_patterns, 500)
end
