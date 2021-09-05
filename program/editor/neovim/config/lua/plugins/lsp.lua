local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.fn.sign_define("LspDiagnosticsSignError", { text = " ", texthl = "LspDiagnosticsSignError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning", { text = " ", texthl = "LspDiagnosticsSignWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ", texthl = "LspDiagnosticsSignInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint", { text = " ", texthl = "LspDiagnosticsSignHint" })

  -- Show diagnostic source
  -- Copied from https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/diagnostic.lua
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = result.diagnostics

    vim.lsp.diagnostic.save(diagnostics, bufnr, ctx.client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    -- don't mutate the original diagnostic because it would interfere with
    -- code action (and probably other stuff, too)
    local prefixed_diagnostics = vim.deepcopy(diagnostics)
    for i, v in pairs(diagnostics) do
      prefixed_diagnostics[i].message = string.format("%s: %s", v.source, v.message)
    end
    vim.lsp.diagnostic.display(prefixed_diagnostics, bufnr, ctx.client_id, config)
  end

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
      vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })
    end)
    vimp.nnoremap({ "override", "silent" }, "[d", function()
      vim.lsp.diagnostic.goto_prev({ popup_opts = { focusable = false } })
    end)
    vimp.nnoremap({ "override", "silent" }, "]d", function()
      vim.lsp.diagnostic.goto_next({ popup_opts = { focusable = false } })
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
