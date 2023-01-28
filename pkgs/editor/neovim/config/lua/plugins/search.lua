return {
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup({
        mapping = {
          ["send_to_qf"] = {
            map = "<leader>Q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all item to quickfix",
          },
        },
        is_insert_mode = true,
      })
    end,
    init = function()
      vim.keymap.set("n", "<Leader>S", "<Cmd>lua require('spectre').open()<CR>", { desc = "Spectre - open" })
      vim.keymap.set(
        "v",
        "<leader>S",
        "<Cmd>lua require('spectre').open_visual()<CR>",
        { desc = "Spectre - open visual" }
      )
      vim.keymap.set(
        "n",
        "<localleader>S",
        "<Cmd>lua require('spectre').open_file_search()<CR>",
        { desc = "Spectre - open current file" }
      )
    end,
  },
  {
    "cshuaimin/ssr.nvim",
    config = function()
      require("ssr").setup({
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_all = "<leader><cr>",
        },
      })
    end,
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>sr", function()
        require("ssr").open()
      end)
    end,
  },
  {
    "inkarkat/vim-SearchAlternatives",
    keys = "/",
    dependencies = { "inkarkat/vim-ingo-library" },
  },
  { "romainl/vim-cool", lazy = false },
  {
    "ironhouzi/starlite-nvim",
    init = function()
      vim.keymap.set("n", "*", "<Cmd>lua require('starlite').star()<CR>")
      vim.keymap.set("n", "g*", "<Cmd>lua require('starlite').g_star()<CR>")
      vim.keymap.set("n", "#", "<Cmd>lua require('starlite').hash()<CR>")
      vim.keymap.set("n", "g#", "<Cmd>lua require('starlite').g_hash()<CR>")
    end,
  },
}
