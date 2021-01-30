require("vimp")
require("core.settings")

-- Extensions
vim.g.coc_global_extensions = {
  "coc-cmake",
  "coc-clangd",
  "coc-emoji",
  "coc-fish",
  "coc-floaterm",
  "coc-fzf-preview",
  "coc-json",
  "coc-lua",
  "coc-markdownlint",
  "coc-pyright",
  "coc-rust-analyzer",
  "coc-snippets",
  "coc-sql",
  "coc-swagger",
  "coc-toml",
  "coc-vimlsp",
  "coc-word",
  "coc-yaml",
  "coc-yank",
}

-- Some servers have issues with backup files, see #649.
vim.o.backup = false
vim.o.writebackup = false

-- Give more space for displaying messages.
vim.o.cmdheight = 2

-- Don't pass messages to |ins-completion-menu|.
vim.cmd("set shortmess+=c")

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.wo.signcolumn = "yes"

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <Tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
function Check_back_space()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

vimp.inoremap({"expr", "silent"}, "<Tab>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-n>"
  else
    if Check_back_space() then
      return "<Tab>"
    else
      return vim.fn["coc#refresh"]()
    end
  end
end)
vimp.inoremap({"expr", "silent"}, "<S-Tab>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-p>"
  else
    return "<C-h>"
  end
end)

-- Use <c-space> to trigger completion.
vimp.inoremap({"expr", "silent"}, "<C-space>", vim.fn["coc#refresh"])

-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
-- position. Coc only does snippet and additional edit on confirm.
vimp.inoremap({"expr"}, "<cr>", function()
  if vim.fn.complete_info()["selected"] ~= "-1" then
    return "<C-y>"
  else
    return "<C-g>u<cr>"
  end
end)

-- Snippets
vim.g.coc_snippet_next = "<Tab>"
vim.g.coc_snippet_prev = "<S-Tab>"

-- Use `[g` and `]g` to navigate diagnostics
vimp.nmap({"silent"}, "[g", "<Plug>(coc-diagnostic-prev)")
vimp.nmap({"silent"}, "]g", "<Plug>(coc-diagnostic-next)")

-- GoTo code navigation.
vimp.nmap({"silent"}, "gd", "<Plug>(coc-definition)")
vimp.nmap({"silent"}, "gD", "<Plug>(coc-declaration)")
vimp.nmap({"silent"}, "gy", "<Plug>(coc-type-definition)")
vimp.nmap({"silent"}, "gI", "<Plug>(coc-implementation)")
vimp.nmap({"silent"}, "gr", "<Plug>(coc-references)")
vimp.nmap({"silent"}, "<space>l", "<Plug>(coc-codelense-action)")

-- Use K to show documentation in preview window.
local function show_docs()
  local cw = vim.fn.expand("<cword>")
  if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
    vim.cmd("h " .. cw)
  elseif vim.fn["coc#rpc#ready"]() then
    vim.fn.CocActionAsync("doHover")
  else
    vim.cmd("!" .. vim.o.keywordprg .. " " .. cw)
  end
end
vimp.nnoremap({"silent"}, "K", show_docs)

-- Highlight the symbol and its references when holding the cursor.
-- autocmd CursorHold * silent call CocActionAsync('highlight')

-- Symbol renaming.
vimp.nmap({"silent"}, "<space>r", "<Plug>(coc-rename)")

-- Formatting selected code.
vimp.nmap({"silent"}, "<space>f", "<Plug>(coc-format)")
vimp.xmap({"silent"}, "<space>f", "<Plug>(coc-format-selected)")
vimp.nnoremap({"silent"}, "<leader>ps", function()
  vim.fn.CocAction("runCommand", "editor.action.organizeImport")
end)

vim.api.nvim_exec([[
        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder.
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end
    ]], false)

-- Apply code actions
vimp.nmap({"silent"}, "<leader>a", ":CocAction<cr>")
vimp.xmap({"silent"}, "<leader>a", "<Plug>(coc-codeaction-selected)")
-- Apply AutoFix to problem on the current line.
vimp.nmap({"silent"}, "<leader>A", "<Plug>(coc-fix-current)")

-- Introduce function text object
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vimp.xmap({"silent"}, "if", "<Plug>(coc-funcobj-i)")
vimp.xmap({"silent"}, "af", "<Plug>(coc-funcobj-a)")
vimp.omap({"silent"}, "if", "<Plug>(coc-funcobj-i)")
vimp.omap({"silent"}, "af", "<Plug>(coc-funcobj-a)")
vimp.xmap({"silent"}, "ic", "<Plug>(coc-classobj-i)")
vimp.xmap({"silent"}, "ac", "<Plug>(coc-classobj-a)")
vimp.omap({"silent"}, "ic", "<Plug>(coc-classobj-i)")
vimp.omap({"silent"}, "ac", "<Plug>(coc-classobj-a)")

-- Remap <C-f> and <C-b> for scroll float windows/popups.
vim.cmd(
  [[nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]])
vim.cmd(
  [[nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]])
vim.cmd(
  [[inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]])
vim.cmd(
  [[inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]])
vim.cmd(
  [[vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]])
vim.cmd(
  [[vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]])

-- Use <leader>l for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vimp.nmap({"silent"}, "<space>L", "<Plug>(coc-range-select)")
vimp.xmap({"silent"}, "<space>L", "<Plug>(coc-range-select)")

-- Add `:Format` command to format current buffer.
vim.cmd([[command! -nargs=0 Format :call CocAction('format')]])

-- Add `:Fold` command to fold current buffer.
vim.cmd([[command! -nargs=? Fold :call CocAction('fold', <f-args>)]])

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.o.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"
                     .. vim.o.statusline

-- Mappings using CoCList:
-- Show all diagnostics.
vimp.nnoremap({"silent"}, "<space>a", ":<C-u>CocList diagnostics<cr>")
-- Manage extensions.
vimp.nnoremap({"silent"}, "<space>e", ":<C-u>CocList extensions<cr>")
-- Show commands.
vimp.nnoremap({"silent"}, "<space>c", ":<C-u>CocList commands<cr>")
-- Find symbol of current document.
vimp.nnoremap({"silent"}, "<space>o", ":<C-u>CocList --auto-preview outline<cr>")
-- Search workspace symbols.
vimp.nnoremap({"silent"}, "<space>s",
  ":<C-u>CocList --interactive --auto-preview symbols<cr>")
-- Do default action for next item.
vimp.nnoremap({"silent"}, "<space>]", ":<C-u>CocNext<cr>")
-- Do default action for previous item.
vimp.nnoremap({"silent"}, "<space>[", ":<C-u>CocPrev<cr>")
-- Do default action for next item.
vimp.nnoremap({"silent"}, "<space>j", function()
  vim.fn.CocAction("runCommand", "document.jumpToNextSymbol")
end)
-- Do default action for previous item.
vimp.nnoremap({"silent"}, "<space>k", function()
  vim.fn.CocAction("runCommand", "document.jumpToPrevSymbol")
end)
-- Resume latest coc list.
vimp.nnoremap({"silent"}, "<space>R", ":<C-u>CocListResume<cr>")
-- Open coc config.
vimp.nnoremap({"silent"}, "<space>i", ":<C-u>CocConfig<cr>")

-- coc-yank
vimp.nnoremap({"silent"}, "<space>y", ":<C-u>CocList -A --normal yank<cr>")
