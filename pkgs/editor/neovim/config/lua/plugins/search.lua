return {
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
    event = "VeryLazy",
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>sr", function()
        require("grug-far").open({ visualSelectionUsage = "auto-detect" })
      end, { desc = "grug-far: Search within range" })
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
