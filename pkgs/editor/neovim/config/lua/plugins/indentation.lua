return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
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
    enabled=false,
  },
  { "Darazaki/indent-o-matic", event = "BufReadPre", enabled = false },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
    event = "BufReadPre",
  },
}
