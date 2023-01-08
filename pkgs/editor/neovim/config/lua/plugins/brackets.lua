return {
  {
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
    enabled = false,
    event = "InsertEnter",
  },
  {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup({ prefix = "r" })
    end,
    enabled = true,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "ys",
          visual = "S",
          delete = "ds",
          change = "cs",
        },
      })
    end,
    enabled = false,
  },
}
