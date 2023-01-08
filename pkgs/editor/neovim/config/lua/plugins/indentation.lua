return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.g.indent_blankline_buftype_exclude = { "nofile", "prompt", "terminal" }
      vim.g.indent_blankline_char = "¦"
      vim.g.indent_blankline_filetype_exclude = { "packer", "startify" }
      require("indent_blankline").setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  { "Darazaki/indent-o-matic", enabled = false },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
}
