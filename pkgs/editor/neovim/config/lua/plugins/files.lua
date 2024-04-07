return {
  { "LunarVim/bigfile.nvim", lazy = false },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    opts = {
      close_if_last_window = false,
      window = {
        mappings = {
          ["l"] = "open",
        },
        width = 40,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
      },
    },
    init = function()
      vim.keymap.set("n", "<Leader>e", ":Neotree reveal toggle<CR>")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
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
