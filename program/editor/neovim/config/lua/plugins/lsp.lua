local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings
  vimp.nnoremap({"override", "silent"}, "gD", vim.lsp.buf.declaration)
  vimp.nnoremap({"override", "silent"}, "gh", "<cmd>Lspsaga lsp_finder<CR>")
  vimp.nnoremap({"override", "silent"}, "gK", "<cmd>Lspsaga signature_help<CR>")

  if client.resolved_capabilities.hover then
    vimp.nnoremap({"override", "silent"}, "K", "<cmd>Lspsaga hover_doc<CR>")
  end
  vimp.nnoremap({"override", "silent"}, "<space>p", "<cmd>Lspsaga preview_definition<CR>")
  vimp.nnoremap({"override", "silent"}, "<space>D", vim.lsp.buf.type_definition)
  if client.resolved_capabilities.rename then
    vimp.nnoremap({"override", "silent"}, "<space>r", "<cmd>Lspsaga rename<CR>")
  end
  vimp.nnoremap({"override", "silent"}, "<space>a", "<cmd>Lspsaga code_action<CR>")
  vimp.xnoremap({"override", "silent"}, "<space>a", "<cmd>Lspsaga range_code_action<CR>")

  vimp.nnoremap({"override", "silent"}, "<space>wa", vim.lsp.buf.add_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wr", vim.lsp.buf.remove_workspace_folder)
  vimp.nnoremap({"override", "silent"}, "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)

  vimp.nnoremap({"override", "silent"}, "<space>d",
    "<cmd>Lspsaga show_line_diagnostics<CR>")
  vimp.nnoremap({"override", "silent"}, "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  vimp.nnoremap({"override", "silent"}, "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  if client.resolved_capabilities.document_formatting then
    vimp.nnoremap({"override", "silent"}, "<space>f", vim.lsp.buf.formatting)
  elseif client.resolved_capabilities.document_range_formatting then
    vimp.vnoremap({"override", "silent"}, "<space>f", vim.lsp.buf.range_formatting)
  end
end
local root_patterns = require("lspconfig").util.root_pattern(".git", ".root")

local servers = {
  "bashls",
  "dockerls",
  "efm",
  "jsonls",
  "pyright",
  "rnix",
  "sourcery",
  "sqls",
  "sumneko",
  "yamlls",
}
for _, name in ipairs(servers) do
  require("plugins.lsp." .. name).setup(on_attach, root_patterns)
end
