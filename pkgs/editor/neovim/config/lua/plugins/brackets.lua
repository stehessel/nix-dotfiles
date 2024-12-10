return {
  {
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup()
    end,
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
    event = "VeryLazy",
  },
}
