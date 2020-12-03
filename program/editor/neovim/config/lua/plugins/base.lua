-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, "packadd packer.nvim")

if not packer_exists then
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
        return
    end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out =
        vim.fn.system(
        string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
    )

    print(out)
    print("Downloading packer.nvim...")

    return
end

return require("packer").startup(
    {
        function()
            -- Packer can manage itself as an optional plugin
            use {
                "wbthomason/packer.nvim",
                opt = true
            }

            use {
                "svermeulen/vimpeccable",
                config = function()
                    require("core.mappings")
                end
            }

            -- Git
            use {
                "APZelos/blamer.nvim",
                cmd = {"BlamerToggle", "BlamerShow", "BlamerHide"},
                config = function()
                    vim.g.blamer_delay = 250
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>gB", ":BlamerToggle<cr>")
                end
            }
            use "jreybert/vimagit"
            use {
                "mhinz/vim-signify",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>vl", ":SignifyList<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vd", ":SignifyDiff<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vf", ":SignifyFold<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vv", ":SignifyHunkDiff<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vu", ":SignifyHunkUndo<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vr", ":SignifyRefresh<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vt", ":SignifyToggle<cr>")
                    vimp.nnoremap({"silent"}, "<leader>vh", ":SignifyToggleHighlight<cr>")

                    vimp.omap({"silent"}, "ig", "<Plug>(signify-motion-inner-pending)")
                    vimp.xmap({"silent"}, "ig", "<Plug>(signify-motion-inner-visual)")
                    vimp.omap({"silent"}, "ag", "<Plug>(signify-motion-outer-pending)")
                    vimp.xmap({"silent"}, "ag", "<Plug>(signify-motion-outer-visual)")

                    vim.cmd [[highlight SignifySignDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
                    vim.cmd [[highlight SignifyLineDelete ctermfg=black ctermbg=darkred guifg=lightgrey guibg=darkred]]
                end
            }
            use {
                "tpope/vim-fugitive",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>gg", ":Git<cr>")
                    vimp.nnoremap({"silent"}, "<leader>gb", ":Git blame<cr>")
                    vimp.nnoremap({"silent"}, "<leader>gc", ":Git commit<cr>")
                    vimp.nnoremap({"silent"}, "<leader>gd", ":Git diff<cr>")
                    vimp.nnoremap({"silent"}, "<leader>gl", ":Git log<cr>")
                    vimp.nnoremap({"silent"}, "<leader>gi", ":Gdiffsplit<cr>")
                end
            }
            -- use "lambdalisue/gina.vim"
            use {
                "rbong/vim-flog",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>gt", ":Flog<CR>")
                end
            }
            use "rhysd/git-messenger.vim"
            -- Github
            use "mattn/vim-gist"
            -- Finders
            use {
                "dyng/ctrlsf.vim",
                config = function()
                    vim.g.ctrlsf_regex_pattern = 1
                    vim.g.ctrlsf_auto_focus = {["at"] = "done", ["duration_less_than"] = 5000}
                    vim.g.ctrlsf_default_root = "project"
                    vim.g.ctrlsf_search_mode = "async"
                    vim.g.ctrlsf_position = "right"
                    vim.g.ctrlsf_mapping = {["vsplit"] = "<C-v>"}

                    require("vimp")
                    vimp.nmap("<leader>jj", "<Plug>CtrlSFPrompt")
                    vimp.xmap({"silent"}, "<leader>jj", "<Plug>CtrlSFVwordExec")
                    vimp.xmap({"silent"}, "<leader>jJ", "<Plug>CtrlSFVwordPath")
                    vimp.nmap({"silent"}, "<leader>jn", "<Plug>CtrlSFCwordPath")
                    vimp.nmap({"silent"}, "<leader>jp", "<Plug>CtrlSFPwordPath")
                    vimp.nnoremap({"silent"}, "<leader>jo", ":CtrlSFOpen<cr>")
                    vimp.nnoremap({"silent"}, "<leader>jt", ":CtrlSFToggle<cr>")
                end
            }
            use {
                "nvim-lua/telescope.nvim",
                config = function()
                    local actions = require("telescope.actions")
                    local sorters = require("telescope.sorters")
                    local themes = require("telescope.themes")
                    require("telescope").setup {
                        defaults = {
                            prompt_prefix = " >",
                            winblend = 0,
                            preview_cutoff = 120,
                            scroll_strategy = "cycle",
                            layout_strategy = "horizontal",
                            layout_defaults = {
                                horizontal = {
                                    width_padding = 0.1,
                                    height_padding = 0.1,
                                    preview_width = 0.6
                                },
                                vertical = {
                                    width_padding = 0.05,
                                    height_padding = 1,
                                    preview_height = 0.5
                                }
                            },
                            sorting_strategy = "descending",
                            prompt_position = "bottom",
                            color_devicons = true,
                            mappings = {
                                i = {
                                    ["<c-x>"] = false,
                                    ["<c-s>"] = actions.goto_file_selection_split
                                }
                            },
                            borderchars = {
                                {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
                                preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
                            },
                            file_sorter = sorters.get_fzy_sorter
                        }
                    }

                    require("vimp")
                    vimp.nnoremap(
                        {"silent"},
                        "<leader>uf",
                        function()
                            require "telescope.builtin".find_files {
                                find_command = {
                                    "rg",
                                    "--files",
                                    "--hidden",
                                    "--ignore-case",
                                    "-g",
                                    "!.git"
                                }
                            }
                        end
                    )
                    vimp.nnoremap(
                        {"silent"},
                        "<leader>ur",
                        function()
                            require "telescope.builtin".lsp_references {shorten_path = true}
                        end
                    )
                end,
                requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"}
            }
            use {
                "junegunn/fzf.vim",
                requires = {
                    "junegunn/fzf",
                    run = function()
                        vim.fn["fzf#install"]()
                    end
                },
                config = function()
                    vim.api.nvim_exec(
                        [[
                            function! g:FzfFilesSource()
                                let l:base = fnamemodify(expand('%'), ':h:.:S')
                                let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'

                                if base == '.'
                                return "rg" . g:grep_params
                                else
                                return printf("rg" . g:grep_params . " | %s %s", l:proximity_sort_path, expand('%'))
                                endif
                            endfunction

                            let g:fzf_tags_command = 'ctags -R'

                            nmap <silent> <leader>ff  :call fzf#vim#files('', {'source': g:FzfFilesSource(), 'options': ['--info=inline', '--preview', 'bat --color=always --style=numbers {}'], 'window': { 'width': 0.9, 'height': 0.9}})<CR>
                            nmap <leader>fb  :Buffers<CR>
                            nmap <leader>fgc :Commits<CR>
                            nmap <leader>fgf :GFiles<CR>
                            nmap <leader>fgs :GFiles?<CR>
                            nmap <leader>fl  :Lines<CR>
                            nmap <leader>f/  :Rg
                            nmap <leader>fm  :Marks<CR>
                            nmap <leader>ft  :Tags<CR>
                            nmap <leader>fbt :BTags<CR>
                            nmap <leader>fc  :History:<CR>
                            nmap <leader>fs  :History/<CR>
                            nmap <leader>fh  :History<CR>
                            nmap <leader>fw  :Windows<CR>
                            nmap <leader>fp  :Filetypes<CR>
                            " Insert mode completion
                            imap <c-x><c-k> <plug>(fzf-complete-word)
                            imap <c-x><c-f> <plug>(fzf-complete-path)
                            imap <c-x><c-j> <plug>(fzf-complete-file)
                            imap <c-x><c-l> <plug>(fzf-complete-line)
                            " Advanced customization using Vim function
                            inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
                        ]],
                        false
                    )
                end
            }
            -- Statusline
            -- use {
            --     "glepnir/galaxyline.nvim",
            --     config = function()
            --         require "spaceline"
            --     end
            -- }
            use {
                "itchyny/lightline.vim",
                config = function()
                    vim.cmd("autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()")
                    vim.cmd("set noshowmode")
                    vim.g.lightline = {
                        ["colorscheme"] = "powerline",
                        ["active"] = {
                            ["left"] = {
                                {"mode", "paste"},
                                {"readonly", "filename", "modified"},
                                {"diagnostic", "cocstatus"}
                            },
                            ["right"] = {{"lineinfo", "percent"}, {"blame", "filetype"}}
                        },
                        ["component_function"] = {
                            ["cocstatus"] = "coc#status",
                            ["gitbranch"] = "FugitiveHead"
                        }
                    }
                end
            }
            -- Start screen
            use {
                "mhinz/vim-startify",
                config = function()
                    vim.g.startify_session_persistence = 1
                    vim.g.startify_update_oldfiles = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>h", ":Startify<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Ss", ":SSave!")
                    vimp.nnoremap({"silent"}, "<leader>Sl", ":SLoad")
                    vimp.nnoremap({"silent"}, "<leader>Sc", ":SClose<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Sd", ":SDelete<cr>")
                end
            }
            -- LSP
            use {
                "neoclide/coc.nvim",
                run = function()
                    vim.fn["coc#util#install"]()
                end,
                config = function()
                    require("plugins.coc")
                end
            }
            use {
                "voldikss/vim-skylight",
                config = function()
                    vimp.nnoremap({"silent"}, "go", ":SkylightJumpTo<cr>")
                    vimp.nnoremap({"silent"}, "gp", ":SkylightPreview<cr>")
                end
            }
            -- use 'neovim/nvim-lsp'
            -- use 'nvim-lua/diagnostic-nvim'
            -- Completion
            -- use 'nvim-lua/completion-nvim'
            -- use 'nvim-treesitter/completion-treesitter'
            -- use 'steelsojka/completion-buffers'
            -- Linters
            -- use {
            --     "dense-analysis/ale",
            --     config = function()
            --         vim.g.ale_fixers = {["python"] = {"black"}}
            --         vim.g.ale_linters = {["python:"] = {"flake8", "pylint", "pyright"}}
            --         vim.g.ale_disable_lsp = 1
            --     end
            -- }
            use {
                "kkoomen/vim-doge",
                config = function()
                    vim.g.doge_doc_standard_python = "numpy"
                end,
                run = function()
                    vim.fn["doge#install"]()
                end
            }
            -- Python
            use {
                "python-rope/ropevim",
                -- after = "vimpeccable",
                config = function()
                    vim.g.ropevim_local_prefix = "<M-r>"
                    vim.g.ropevim_global_prefix = "<M-p>"
                    vim.g.ropevim_autoimport_modules = {"*"}
                    vim.g.ropevim_enable_autoimport = 1
                    vim.g.ropevim_guess_project = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<M-,>", ":RopeCodeAssist<cr>")
                    vimp.nnoremap({"silent"}, "<M-.>", ":RopeLuckyAssist<cr>")
                    vimp.nnoremap({"silent"}, "<M-cr>", ":RopeAutoImport<cr>")
                    vimp.nnoremap({"silent"}, "<M-d>", ":RopeGotoDefinition<cr>")
                end,
                ft = "python"
            }
            -- use {"anihm136/importmagic.nvim", ft = "python"}
            use "stsewd/sphinx.nvim"
            -- Clojure
            use "clojure-vim/vim-jack-in"
            use {"tpope/vim-fireplace", ft = "clojure", cmd = "FireplaceConnect"}
            -- Lua
            use "bfredl/nvim-luadev"
            -- Treesitter
            use {
                "nvim-treesitter/nvim-treesitter",
                config = function()
                    require("plugins.treesitter")
                end
            }
            use {"nvim-treesitter/nvim-treesitter-refactor", requires = "nvim-treesitter/nvim-treesitter"}
            use {"nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter"}
            -- Format
            use {
                "sbdchd/neoformat",
                config = function()
                    vim.cmd [[augroup format]]
                    vim.cmd [[autocmd!]]
                    vim.cmd [[autocmd BufWritePre *.lua,*.py,*.sql undojoin | Neoformat]]
                    vim.cmd [[augroup END]]

                    vim.g.neoformat_enabled_json = {"prettier"}
                    vim.g.neoformat_enabled_lua = {"luafmt"}
                    vim.g.neoformat_enabled_python = {"black"}
                    vim.g.neoformat_enabled_sql = {"pg_format"}
                    vim.g.neoformat_enabled_yaml = {"prettier"}

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>F", ":Neoformat<cr>")
                end
            }
            use "tpope/vim-endwise"
            -- Snippets
            -- use 'honza/vim-snippets'
            -- Debugger
            -- use {
            --     "puremourning/vimspector",
            --     config = function()
            --         vim.g.vimspector_enable_mappings = "HUMAN"
            --         vim.g.vimspector_install_gadgets = {"debugpy", "CodeLLDB"}
            --         vim.g.vimspector_sign_priority = {
            --             ["vimspectorBP"] = 50,
            --             ["vimspectorBPCond"] = 40,
            --             ["vimspectorBPDisabled"] = 30,
            --             ["vimspectorPC"] = 999
            --         }
            --     end
            -- }
            use {
                "mfussenegger/nvim-dap-python",
                config = function()
                    require("dap-python").setup("python")
                    require("dap-python").test_runner = "pytest"

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<F4>", require("dap").list_breakpoints)
                    vimp.nnoremap({"silent"}, "<F5>", require("dap").continue)
                    vimp.nnoremap({"silent"}, "<F6>", require("dap").repl.toggle)
                    vimp.nnoremap({"silent"}, "<F8>", require("dap").goto_)
                    vimp.nnoremap({"silent"}, "<F9>", require("dap").toggle_breakpoint)
                    vimp.nnoremap(
                        {"silent"},
                        "<leader><F9>",
                        function()
                            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                        end
                    )
                    vimp.nnoremap({"silent"}, "<F10>", require("dap").step_over)
                    vimp.nnoremap({"silent"}, "<F11>", require("dap").step_into)
                    vimp.nnoremap({"silent"}, "<F12>", require("dap").step_out)
                end,
                requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"}
            }
            use {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    vim.g.dap_virtual_text = true
                end,
                requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"}
            }
            -- Testing
            use {
                "janko/vim-test",
                config = function()
                    vim.g["test#python#runner"] = "pytest"
                    vim.g["test#python#pytest#options#"] = {["all"] = "--capture=no"}
                    vim.g["test#strategy"] = "neoterm"

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>tn", ":TestNearest<cr>")
                    vimp.nnoremap({"silent"}, "<leader>tf", ":TestFile<cr>")
                    vimp.nnoremap({"silent"}, "<leader>ts", ":TestSuite<cr>")
                    vimp.nnoremap({"silent"}, "<leader>tl", ":TestLast<cr>")
                    vimp.nnoremap({"silent"}, "<leader>tg", ":TestVisit<cr>")

                    vim.api.nvim_exec(
                        [[
                            function! DockerPythonTransform(cmd) abort
                                let container_id = system("docker ps --filter 'name=raq' --quiet")
                                let port = 6000
                                return 'docker exec '.container_id.' /home/docker/venv3.6/bin/python -m debugpy --listen 0.0.0.0:'.port.' --wait-for-client -m '.a:cmd
                            endfunction

                            let g:test#custom_transformations = {'docker-python': function('DockerPythonTransform')}
                        ]],
                        false
                    )

                    vim.cmd [[augroup raq_tests]]
                    vim.cmd [[autocmd!]]
                    vim.cmd [[autocmd BufRead,BufNewFile **/git/raq/* execute 'let g:test#transformation = "docker-python"']]
                    vim.cmd [[augroup END]]
                end
            }
            -- Code folding
            -- use 'kalekundert/vim-coiled-snake'
            use "Konfekt/FastFold"
            use "tmhedberg/SimpylFold"
            -- Syntax highlighters
            use {
                "numirias/semshi",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>rn", ":Semshi rename<cr>")
                    vimp.nnoremap({"silent"}, "<Space><Tab>", ":Semshi goto name next<cr>")
                    vimp.nnoremap({"silent"}, "<Space><S-Tab>", ":Semshi goto name prev<cr>")
                    vimp.nnoremap({"silent"}, "<Space>k", ":Semshi goto class next<cr>")
                    vimp.nnoremap({"silent"}, "<Space>K", ":Semshi goto class prev<cr>")
                    vimp.nnoremap({"silent"}, "<Space>f", ":Semshi goto function next<cr>")
                    vimp.nnoremap({"silent"}, "<Space>F", ":Semshi goto function prev<cr>")
                    vimp.nnoremap({"silent"}, "<Space>gu", ":Semshi goto unresolved first<cr>")
                    vimp.nnoremap({"silent"}, "<Space>gp", ":Semshi goto parameterUnused first<cr>")
                    vimp.nnoremap({"silent"}, "<Space>ee", ":Semshi error<cr>")
                    vimp.nnoremap({"silent"}, "<Space>ge", ":Semshi goto error<cr>")
                end,
                ft = "python"
            }
            use "sheerun/vim-polyglot"
            -- REPL
            -- use 'ipselium/vim-cpyvke'
            use {
                "kassio/neoterm",
                -- after = "vimpeccable",
                config = function()
                    vim.g.neoterm_default_mod = "rightbelow vertical"
                    vim.g.neoterm_autoinsert = 1

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>Tt", ":Ttoggle<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tr", ":TREPLSetTerm<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tf", ":TREPLSendFile<cr>")
                    vimp.nnoremap({"silent"}, "<leader>Tl", ":TREPLSendLine<cr>")
                    vimp.xnoremap({"silent"}, "<leader>Tl", ":TREPLSendSelection<cr>")
                    vimp.rbind("nx", "gx", "<Plug>neoterm-repl-send")
                end
            }
            use {
                "Olical/conjure",
                config = function()
                    vim.cmd [[let g:conjure#log#hud#width = 0.42]]
                end,
                ft = {"clojure", "fennel"}
            }
            use {
                "hkupty/iron.nvim",
                -- after = "vimpeccable",
                config = function()
                    local iron = require("iron")

                    iron.core.set_config {
                        preferred = {
                            python = "ipython"
                        }
                    }

                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>it", ":IronRepl python<cr><ESC>")
                    vimp.nnoremap({"silent"}, "<leader>if", ":IronFocus python<cr>")
                    vimp.nnoremap({"silent"}, "<leader>ir", ":IronRestart<cr>")
                    vimp.nnoremap({"silent"}, "<leader>iw", ":IronWatchCurrentFile")
                    vimp.nnoremap({"silent"}, "<leader>iu", ":IronUnwatchCurrentFile<cr>")

                    -- vimp.nmap({"silent"}, "<localleader>s", "<Plug>iron-send-motion")
                    -- vimp.vmap({"silent"}, "<localleader>s", "<Plug>iron-visual-send")
                    -- vimp.vmap({"silent"}, "<localleader>r", "<Plug>iron-repeat-cmd")
                    vimp.vmap({"silent"}, "<localleader>l", "<Plug>iron-send-line")
                    vimp.vmap({"silent"}, "<localleader><cr>", "<Plug>iron-cr")
                    vimp.vmap({"silent"}, "<localleader>i", "<Plug>iron-interrupt")
                    vimp.vmap({"silent"}, "<localleader>q", "<Plug>iron-exit")
                    vimp.vmap({"silent"}, "<localleader>c", "<Plug>iron-clear")
                end
            }
            use "tpope/vim-markdown"
            -- Tabs
            use "gcmt/taboo.vim"
            -- Color scheme
            use {
                "sainnhe/sonokai",
                config = function()
                    vim.g.sonokai_style = "andromeda"
                    vim.g.sonokai_enable_itatlic = 1
                    vim.g.sonokai_diagnostic_line_highlight = 0
                    vim.g.sonokai_better_performance = 1
                    vim.cmd("colorscheme sonokai")
                end
            }
            -- Icons
            use {
                "kyazdani42/nvim-web-devicons",
                config = function()
                    require "nvim-web-devicons".setup {
                        default = true
                    }
                end
            }
            -- Brackets
            use "adelarsq/vim-matchit"
            use "cohama/lexima.vim"
            use {
                "luochen1990/rainbow",
                setup = function()
                    vim.g.rainbow_active = 1
                end
            }
            use "machakann/vim-sandwich"
            -- Marks
            use "inkarkat/vim-mark"
            use "kshenoy/vim-signature"
            -- Indentation
            use {
                "lukas-reineke/indent-blankline.nvim",
                config = function()
                    vim.g.indent_blankline_char = "¦"
                end
            }
            use "tpope/vim-sleuth"
            use "Yggdroot/indentLine"
            -- Keybinds
            use "tpope/vim-unimpaired"
            -- Movement
            use "easymotion/vim-easymotion"
            use "rhysd/clever-f.vim"
            use "tpope/vim-rsi"
            -- Text manipulation
            use {
                "AndrewRadev/switch.vim",
                config = function()
                    vim.g.switch_mapping = "-"
                end
            }
            use {
                "junegunn/vim-easy-align",
                -- after = "vimpeccable",
                cmd = "EasyAlign",
                setup = function()
                    require("vimp")
                    -- Start interactive EasyAlign in visual mode (e.g. vipga)
                    vimp.xnoremap({"silent"}, "ga", ":EasyAlign<cr>")
                    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
                    vimp.nnoremap({"silent"}, "ga", ":EasyAlign<cr>")
                end
            }
            use {
                "tpope/vim-sexp-mappings-for-regular-people",
                after = "vim-sexp",
                ft = {"clojure", "fennel"}
            }
            use {
                "guns/vim-sexp",
                config = function()
                    vim.g.sexp_enable_insert_mode_mappings = 0
                end,
                ft = {"clojure", "fennel"}
            }
            use "matze/vim-move"
            use {
                "machakann/vim-swap",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.rbind("ox", "i,", "<Plug>(swap-textobject-i)")
                    vimp.rbind("ox", "a,", "<Plug>(swap-textobject-a)")
                end
            }
            use "mg979/vim-visual-multi"
            use {
                "nicwest/vim-camelsnek",
                -- after = "vimpeccable",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xs", ":Snek<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xc", ":Camel<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xb", ":CamelB<cr>")
                    vimp.nnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
                    vimp.xnoremap({"silent"}, "<leader>xk", ":Kebab<cr>")
                end
            }
            use "tommcdo/vim-exchange"
            use "tpope/vim-repeat"
            use "tyru/caw.vim"
            -- Text substitution
            use {
                "svermeulen/vim-subversive",
                -- after = "vimpeccable",
                config = function()
                    vim.cmd [[nmap s <Plug>(SubversiveSubstitute)]]
                    vim.cmd [[nmap ss <Plug>(SubversiveSubstituteLine)]]
                    vim.cmd [[nmap sl <Plug>(SubversiveSubstituteToEndOfLine)]]

                    vim.cmd [[xmap s <Plug>(SubversiveSubstitute)]]
                    vim.cmd [[xmap p <Plug>(SubversiveSubstitute)]]
                    vim.cmd [[xmap P <Plug>(SubversiveSubstitute)]]

                    vim.cmd [[nmap <leader><leader>s <Plug>(SubversiveSubvertRange)]]
                    vim.cmd [[xmap <leader><leader>s <Plug>(SubversiveSubvertRange)]]
                    vim.cmd [[nmap <leader><leader>ss <Plug>(SubversiveSubvertWordRange)]]

                    vim.cmd [[nmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]]
                    vim.cmd [[xmap <leader>cs <Plug>(SubversiveSubstituteRangeConfirm)]]
                    vim.cmd [[nmap <leader>css <Plug>(SubversiveSubstituteWordRangeConfirm)]]

                    require("vimp")
                    -- ie = inner entire buffer
                    vimp.onoremap({"silent"}, "ie", [[:exec "normal! ggVG"<cr>]])
                    -- iv = current viewable text in the buffer
                    vimp.onoremap({"silent"}, "iv", [[:exec "normal! HVL"<cr>]])
                end
            }
            use "tpope/vim-abolish"
            -- Text splitting
            use "AndrewRadev/splitjoin.vim"
            use {"sk1418/Join", cmd = "Join"}
            -- Text objects
            use {
                "chaoren/vim-wordmotion",
                config = function()
                    vim.g.wordmotion_mappings = {
                        ["w"] = "<M-w>",
                        ["b"] = "<M-b>",
                        ["e"] = "<M-e>",
                        ["ge"] = "g<M-e>",
                        ["aw"] = "a<M-w>",
                        ["iw"] = "i<M-w>",
                        ["<C-R><C-W>"] = "<C-R><M-w>"
                    }
                end
            }
            use "glts/vim-textobj-comment"
            use "julian/vim-textobj-variable-segment"
            use "kana/vim-textobj-user"
            use "michaeljsmith/vim-indent-object"
            use "wellle/targets.vim"
            -- Buffers
            use "jlanzarotta/bufexplorer"
            use "moll/vim-bbye"
            use {
                "wfxr/minimap.vim",
                config = function()
                    require("vimp")
                    vimp.nnoremap({"silent"}, "<leader>C", ":MinimapToggle<cr>")
                end
            }
            -- use 'TaDaa/vimade'
            -- Splits
            -- use 'camspiers/lens.vim'
            -- Tabs
            use "caenrique/nvim-maximize-window-toggle"
            -- Tmux
            use "christoomey/vim-tmux-navigator"
            use "tmux-plugins/vim-tmux-focus-events"
            -- File explorer
            -- use {
            --     "lambdalisue/fern.vim",
            --     config = function()
            --         -- let g:fern#renderer = "nerdfont"
            --         -- let g:fern#disable_default_mappings = 1
            --         --
            --         -- nmap <silent> <leader>Ee :Fern . -drawer -reveal=% -toggle<CR>
            --         -- nmap <silent> <leader>Ef :Fern . -drawer -reveal=%<CR>
            --         -- map <silent> <leader>Eb :Fern bookmark:/// -drawer <CR>
            --         -- function! s:fern_init() abort
            --         -- 	nmap <buffer> o <Plug>(fern-action-open:edit)
            --         -- 	nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
            --         -- 	nmap <buffer> t <Plug>(fern-action-open:tabedit)
            --         -- 	nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
            --         -- 	nmap <buffer> i <Plug>(fern-action-open:split)
            --         -- 	nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
            --         -- 	nmap <buffer> s <Plug>(fern-action-open:vsplit)
            --         -- 	nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
            --         -- 	nmap <buffer> P gg
            --         -- 	nmap <buffer> C <Plug>(fern-action-enter)
            --         -- 	nmap <buffer> u <Plug>(fern-action-leave)
            --         -- 	nmap <buffer> r <Plug>(fern-action-reload)
            --         -- 	nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
            --         -- 	nmap <buffer> cd <Plug>(fern-action-cd)
            --         -- 	nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
            --         -- 	nmap <buffer> I <Plug>(fern-action-hide-toggle)
            --         -- 	nmap <buffer> q :<C-u>quit<CR>
            --         -- endfunction
            --         -- augroup fern-custom
            --         -- 	autocmd! *
            --         -- 	autocmd FileType fern call s:init_fern()
            --         -- augroup END
            --     end
            -- }
            -- use 'lambdalisue/fern-bookmark.vim'
            -- use 'lambdalisue/fern-renderer-nerdfont.vim'
            -- Projects
            use {
                "tpope/vim-projectionist",
                config = function()
                    vim.g.projectionist_heuristics = {["data_catalog/*.py"] = {["alternate"] = "tests/unit/test_{}.py"}}

                    require("vimp")
                    -- vimp.nnoremap({"silent"}, "go", ":A<cr>")
                end
            }
            -- Search
            use "markonm/traces.vim"
            use {
                "brooth/far.vim",
                config = function()
                    vim.g["far#source"] = "rgnvim"

                    require("vimp")
                    -- vimp.nnoremap({"silent"}, "<leader>rf", ":Farf<cr>")
                    -- vimp.xnoremap({"silent"}, "<leader>rf", ":Farf<cr>")
                    -- vimp.nnoremap({"silent"}, "<leader>rr", ":Farr<cr>")
                    -- vimp.xnoremap({"silent"}, "<leader>rr", ":Farr<cr>")
                end
            }
            use {"inkarkat/vim-SearchAlternatives", requires = "inkarkat/vim-ingo-library"}
            -- use 'pgdouyon/vim-evanesco'
            -- Copy/paste
            use "machakann/vim-highlightedyank"
            use {
                "svermeulen/vim-yoink",
                config = function()
                    require("vimp")
                    vimp.nmap({"silent"}, "<M-]>", "<Plug>(YoinkPostPasteSwapBack)")
                    vimp.nmap({"silent"}, "<M-[>", "<Plug>(YoinkPostPasteSwapForward)")
                    vimp.rbind("nx", {"silent"}, "y", "<Plug>(YoinkYankPreserveCursorPosition)")
                    vimp.nmap({"silent"}, "p", "<Plug>(YoinkPaste_p)")
                    vimp.nmap({"silent"}, "P", "<Plug>(YoinkPaste_P)")
                    vimp.nmap({"silent"}, "[y", "<Plug>(YoinkRotateBack)")
                    vimp.nmap({"silent"}, "]y", "<Plug>(YoinkRotateForward)")
                    vimp.nmap({"silent"}, "<C-=>", "<Plug>(YoinkPostPasteToggleFormat)")
                end
            }
            -- Discover keybinds
            use {
                "liuchengxu/vim-which-key",
                cmd = {"WhichKey"},
                setup = function()
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>",
                        ":WhichKey '<leader>'<cr>",
                        {noremap = true, silent = true}
                    )
                end
            }
            -- Save position
            use "farmergreg/vim-lastplace"
            -- Note taking
            use "vimwiki/vimwiki"
            -- Dispatcher
            use {
                "skywind3000/asynctasks.vim",
                cmd = {"AsyncTask", "AsyncTaskEdit", "AsyncTaskList", "AsyncTaskMacro", "AsyncTaskProfile"},
                requires = {
                    "skywind3000/asyncrun.vim",
                    setup = function()
                        vim.g.asyncrun_open = 12
                    end
                }
            }
            use {"tpope/vim-dispatch", cmd = {"Dispatch", "Make", "Focus", "Start"}}
            -- Todo
            use "vuciv/vim-bujo"
            -- Unix commands
            use "tpope/vim-eunuch"
            -- Root directory
            use {
                "airblade/vim-rooter",
                config = function()
                    vim.g.rooter_silent_chdir = 1
                end
            }
            -- Autosave
            use {
                "907th/vim-auto-save",
                setup = function()
                    vim.g.auto_save = 0
                    vim.g.auto_save_silent = 1
                    vim.g.auto_save_events = {"InsertLeave", "FocusLost"}
                end
            }
            -- Benchmark
            use "tweekmonster/startuptime.vim"
        end,
        config = {max_jobs = 32}
    }
)
