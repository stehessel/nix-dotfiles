return {
  { "nvim-lua/plenary.nvim" },
  {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require("litee.lib").setup({})
      require("litee.calltree").setup({ layout_size = 40, icons = "codicon" })
    end,
    dependencies = { "ldelossa/litee.nvim" },
  },
}
