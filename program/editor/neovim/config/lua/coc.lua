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
    "coc-python",
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
vim.cmd [[set hidden]]

-- Some servers have issues with backup files, see #649.
vim.cmd [[set nobackup]]
vim.cmd [[set nowritebackup]]

-- Give more space for displaying messages.
vim.cmd [[set cmdheight=1]]

-- Don't pass messages to |ins-completion-menu|.
vim.cmd [[set shortmess+=c]]

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd [[set signcolumn=yes]]

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
vim.cmd [[ inoremap <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh() ]]
vim.cmd [[ inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>" ]]

vim.cmd [[ function! s:check_back_space() abort
                    let col = col('.') - 1
                    return !col || getline('.')[col - 1]  =~# '\s'
                endfunction ]]

-- Use <c-space> to trigger completion.
vim.cmd [[ inoremap <silent><expr> <c-space> coc#refresh() ]]

-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
-- position. Coc only does snippet and additional edit on confirm.
-- Use `complete_info` if your (Neo)Vim version supports it.
vim.cmd [[ inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>" ]]

-- Snippets
-- Use <C-l> for trigger snippet expand.
vim.cmd [[ imap <C-l> <Plug>(coc-snippets-expand) ]]
-- Use <C-j> for select text for visual placeholder of snippet.
vim.cmd [[ vmap <C-j> <Plug>(coc-snippets-select) ]]
-- Use <C-j> for jump to next placeholder, it's default of coc.nvim
vim.g.coc_snippet_next = "<c-j>"
-- Use <C-k> for jump to previous placeholder, it's default of coc.nvim
vim.g.coc_snippet_prev = "<c-k>"
-- Use <C-j> for both expand and jump (make expand higher priority.)
vim.cmd [[ imap <C-j> <Plug>(coc-snippets-expand-jump) ]]

-- Use `[g` and `]g` to navigate diagnostics
vim.cmd [[ nmap <silent> [g <Plug>(coc-diagnostic-prev) ]]
vim.cmd [[ nmap <silent> ]g <Plug>(coc-diagnostic-next) ]]

-- GoTo code navigation.
vim.cmd [[ nmap <silent> gd <Plug>(coc-definition) ]]
vim.cmd [[ nmap <silent> gD <Plug>(coc-declaration) ]]
vim.cmd [[ nmap <silent> gy <Plug>(coc-type-definition) ]]
vim.cmd [[ nmap <silent> gp <Plug>(coc-implementation) ]]
vim.cmd [[ nmap <silent> gr <Plug>(coc-references) ]]
vim.cmd [[ nmap <silent> gl <Plug>(coc-codelense-action) ]]

-- Use K to show documentation in preview window.
vim.cmd [[ nnoremap <silent> K :call <SID>show_documentation()<CR> ]]

vim.cmd [[ function! s:show_documentation()
                    if (index(['vim','help'], &filetype) >= 0)
                        execute 'h '.expand('<cword>')
                    else
                        call CocAction('doHover')
                    endif
                endfunction ]]

-- Highlight the symbol and its references when holding the cursor.
-- autocmd CursorHold * silent call CocActionAsync('highlight')

-- Symbol renaming.
vim.cmd [[ nmap <space>r <Plug>(coc-rename) ]]

-- Formatting selected code.
vim.cmd [[ xmap <leader>F   <Plug>(coc-format-selected) ]]
vim.cmd [[ nmap <leader>F   <Plug>(coc-format) ]]
vim.cmd [[ nmap <leader>ps  :CocCommand python.sortImports<CR> ]]

vim.cmd [[ augroup mygroup
                    autocmd!
                    -- Setup formatexpr specified filetype(s).
                    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
                    -- Update signature help on jump placeholder.
                    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
                augroup end ]]

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.cmd [[ xmap <leader>A  <Plug>(coc-codeaction-selected) ]]
vim.cmd [[ nmap <leader>A  <Plug>(coc-codeaction-selected) ]]

-- Remap keys for applying codeAction to the current line.
vim.cmd [[ nmap <leader>Ac  <Plug>(coc-codeaction) ]]
-- Apply AutoFix to problem on the current line.
vim.cmd [[ nmap <leader>Qf  <Plug>(coc-fix-current) ]]

-- Introduce function text object
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.cmd [[ xmap if <Plug>(coc-funcobj-i) ]]
vim.cmd [[ xmap af <Plug>(coc-funcobj-a) ]]
vim.cmd [[ omap if <Plug>(coc-funcobj-i) ]]
vim.cmd [[ omap af <Plug>(coc-funcobj-a) ]]

-- Use <TAB> for selections ranges.
-- NOTE: Requires 'textDocument/selectionRange' support from the language server.
-- coc-tsserver, coc-python are the examples of servers that support it.
vim.cmd [[ nmap <silent> <leader><TAB> <Plug>(coc-range-select) ]]
vim.cmd [[ xmap <silent> <leader><TAB> <Plug>(coc-range-select) ]]

-- Add `:Format` command to format current buffer.
vim.cmd [[ command! -nargs=0 Format :call CocAction('format') ]]

-- Add `:Fold` command to fold current buffer.
vim.cmd [[ command! -nargs=? Fold :call CocAction('fold', <f-args>) ]]

-- Add `:OR` command for organize imports of the current buffer.
vim.cmd [[ command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport') ]]

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.cmd [[ set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')} ]]

-- Mappings using CoCList:
-- Show all diagnostics.
vim.cmd [[ nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr> ]]
-- Manage extensions.
vim.cmd [[ nnoremap <silent> <space>e  :<C-u>CocList extensions<cr> ]]
-- Show commands.
vim.cmd [[ nnoremap <silent> <space>c  :<C-u>CocList commands<cr> ]]
-- Find symbol of current document.
vim.cmd [[ nnoremap <silent> <space>o  :<C-u>CocList --auto-preview outline<cr> ]]
-- Search workspace symbols.
vim.cmd [[ nnoremap <silent> <space>s  :<C-u>CocList --interactive --auto-preview symbols<cr> ]]
-- Do default action for next item.
vim.cmd [[ nnoremap <silent> <space>]  :<C-u>CocNext<CR> ]]
-- Do default action for previous item.
vim.cmd [[ nnoremap <silent> <space>[  :<C-u>CocPrev<CR> ]]
-- Resume latest coc list.
vim.cmd [[ nnoremap <silent> <space>l  :<C-u>CocListResume<CR> ]]
-- Open coc config.
nvim.cmd [[ noremap <silent> <space>f  :<C-u>CocConfig<CR> ]]
-- coc-explorer
vim.cmd [[ nmap <silent> <leader>ef :CocCommand explorer --no-toggle<CR> ]]
vim.cmd [[ nmap <silent> <leader>ee :CocCommand explorer<CR> ]]
-- coc-yank
vim.cmd [[ nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<CR> ]]
