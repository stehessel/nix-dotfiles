return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
      vim.keymap.set("n", "<Leader>j", require("neogen").generate, { desc = "Neogen - generate" })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },
  { "stsewd/sphinx.nvim", ft = { "python", "rst" } },
}
