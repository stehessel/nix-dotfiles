return {
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker")
    end,
    init = function()
      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<Leader>i", "<Cmd>PickIcons<CR>", opts)
      vim.keymap.set("i", "<Localleader>i", "<Cmd>PickIconsInsert<CR>", opts)
      vim.keymap.set("i", "<A-i>", "<Cmd>PickAltFontAndSymbolsInsert<CR>", opts)
    end,
  },
}
