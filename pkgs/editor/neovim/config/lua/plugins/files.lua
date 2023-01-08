return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = { "Neotree" },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.g.neo_tree_remove_legacy_commands = 1

      require("neo-tree").setup({
        close_if_last_window = false,
        window = {
          mappings = {
            ["l"] = "open",
          },
          width = 40,
        },
        filesystem = {
          follow_current_file = true,
          group_empty_dirs = true,
          use_libuv_file_watcher = true,
        },
      })
    end,
    init = function()
      vim.keymap.set("n", "<Leader>e", ":Neotree reveal toggle<CR>")
    end,
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "tpope/vim-projectionist",
    config = function()
      vim.g.projectionist_heuristics = {
        ["data_catalog/*.py"] = { ["alternate"] = "tests/unit/test_{}.py" },
      }
    end,
  },
}
