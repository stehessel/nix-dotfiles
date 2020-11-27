require("vimp")
require("core.settings")

-- Extensions
vim.g.coc_global_extensions = {
    "coc-actions",
    "coc-cmake",
    "coc-clangd",
    "coc-emoji",
    "coc-explorer",
    "coc-floaterm",
    "coc-json",
    "coc-markdownlint",
    "coc-pyright",
    "coc-rust-analyzer",
    "coc-snippets",
    "coc-sql",
    "coc-tabnine",
    "coc-vimlsp",
    "coc-word",
    "coc-yaml",
    "coc-yank"
}

-- TextEdit might fail if hidden is not set.
vim.o.hidden = true

-- Some servers have issues with backup files, see #649.
vim.o.backup = false
vim.o.writebackup = false

-- Give more space for displaying messages.
vim.o.cmdheight = 1

-- Don't pass messages to |ins-completion-menu|.
vim.cmd("set shortmess+=c")

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.o.signcolumn = "yes"

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
vim.api.nvim_exec(
    [[
        function! Check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : Check_back_space() ? "\<TAB>" : coc#refresh()
        inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"
    ]],
    false
)

-- Use <c-space> to trigger completion.
vimp.inoremap({"expr", "silent"}, "<C-space>", vim.fn["coc#refresh"])

-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
-- position. Coc only does snippet and additional edit on confirm.
vim.cmd([[inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<cr>"]])

--Snippets
vimp.inoremap({"silent"}, "<C-l>", "<Plug>(coc-snippets-expand)")
vimp.vnoremap({"silent"}, "<C-j>", "<Plug>(coc-snippets-select)")
vimp.inoremap({"silent"}, "<C-j>", "<Plug>(coc-snippets-expand-jump)")
vim.g.coc_snippet_next = "<C-j>"
vim.g.coc_snippet_prev = "<C-k>"

-- Use `[g` and `]g` to navigate diagnostics
vimp.nmap({"silent"}, "[g", "<Plug>(coc-diagnostic-prev)")
vimp.nmap({"silent"}, "]g", "<Plug>(coc-diagnostic-next)")

-- GoTo code navigation.
vimp.nmap({"silent"}, "gd", "<Plug>(coc-definition)")
vimp.nmap({"silent"}, "gD", "<Plug>(coc-declaration)")
vimp.nmap({"silent"}, "gy", "<Plug>(coc-type-definition)")
vimp.nmap({"silent"}, "gp", "<Plug>(coc-implementation)")
vimp.nmap({"silent"}, "gr", "<Plug>(coc-references)")
vimp.nmap({"silent"}, "<space>l", "<Plug>(coc-codelense-action)")

-- Use K to show documentation in preview window.
vim.api.nvim_exec(
    [[
        function! Show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        nnoremap <silent> K :call Show_documentation()<cr>
    ]],
    false
)

-- Highlight the symbol and its references when holding the cursor.
-- autocmd CursorHold * silent call CocActionAsync('highlight')

-- Symbol renaming.
vimp.nnoremap({"silent"}, "<space>r", "<Plug>(coc-rename)")

-- Formatting selected code.
vimp.nnoremap({"silent"}, "<space>G", "<Plug>(coc-format)")
vimp.xnoremap({"silent"}, "<space>G", "<Plug>(coc-format-selected)")
vimp.nnoremap({"silent"}, "<leader>ps", ":CocCommand python.sortImports<cr>")

vim.api.nvim_exec(
    [[
        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder.
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end
    ]],
    false
)

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vimp.nnoremap({"silent"}, "<leader>a", "<Plug>(coc-code-action-selected)")
vimp.xnoremap({"silent"}, "<leader>a", "<Plug>(coc-code-action-selected)")
-- Remap keys for applying codeAction to the current line.
vim.cmd("nnoremap <silent> <leader>aa :CocAction<cr>")
-- Apply AutoFix to problem on the current line.
vimp.nnoremap({"silent"}, "<leader>A", "<Plug>(coc-fix-current)")

-- Introduce function text object
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vimp.xnoremap({"silent"}, "if", "<Plug>(coc-funcobj-i)")
vimp.xnoremap({"silent"}, "af", "<Plug>(coc-funcobj-a)")
vimp.onoremap({"silent"}, "if", "<Plug>(coc-funcobj-i)")
vimp.onoremap({"silent"}, "af", "<Plug>(coc-funcobj-a)")

-- Use <TAB> for selections ranges.
-- NOTE: Requires 'textDocument/selectionRange' support from the language server.
-- coc-tsserver, coc-python are the examples of servers that support it.
vimp.nnoremap({"silent"}, "<leader><tab>", "<Plug>(coc-range-select)")
vimp.xnoremap({"silent"}, "<leader><tab>", "<Plug>(coc-range-select)")

-- Add `:Format` command to format current buffer.
vim.cmd([[command! -nargs=0 Format :call CocAction('format')]])

-- Add `:Fold` command to fold current buffer.
vim.cmd([[command! -nargs=? Fold :call CocAction('fold', <f-args>)]])

-- Add `:OR` command for organize imports of the current buffer.
vim.cmd([[command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')]])

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.cmd([[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]])

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
vimp.nnoremap({"silent"}, "<space>s", ":<C-u>CocList --interactive --auto-preview symbols<cr>")
-- Do default action for next item.
vimp.nnoremap({"silent"}, "<space>]", ":<C-u>CocNext<cr>")
-- Do default action for previous item.
vimp.nnoremap({"silent"}, "<space>[", ":<C-u>CocPrev<cr>")
-- Resume latest coc list.
vimp.nnoremap({"silent"}, "<space>R", ":<C-u>CocListResume<cr>")
-- Open coc config.
vimp.nnoremap({"silent"}, "<space>i", ":<C-u>CocConfig<cr>")

-- coc-explorer
vimp.nnoremap({"silent"}, "<leader>ef", ":CocCommand explorer --no-toggle<cr>")
vimp.nnoremap({"silent"}, "<leader>ee", ":CocCommand explorer<cr>")

-- coc-yank
vimp.nnoremap({"silent"}, "<leader>y", ":<C-u>CocList -A --normal yank<cr>")
