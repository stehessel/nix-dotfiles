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
