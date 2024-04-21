return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = {
        char = "¦",
      },
      exclude = {
        buftypes = { "nofile", "prompt", "terminal" },
        filetypes = { "packer", "startify" },
      },
    },
  },
  { "Darazaki/indent-o-matic", event = "VeryLazy", enabled = false },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
    event = "VeryLazy",
  },
}
