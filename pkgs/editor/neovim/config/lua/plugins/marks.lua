return {
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({ excluded_filetypes = { "neotest-summary" } })
    end,
    event = "VeryLazy",
  },
}
