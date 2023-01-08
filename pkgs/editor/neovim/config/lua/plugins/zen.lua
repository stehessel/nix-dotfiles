return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    init = function()
      vim.keymap.set("n", "<Leader>z", "<Cmd>ZenMode<CR>")
    end,
  },
}
