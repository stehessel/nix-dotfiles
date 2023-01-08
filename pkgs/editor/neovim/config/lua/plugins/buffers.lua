return {
  { "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },
  {
    "wfxr/minimap.vim",
    cmd = "MinimapToggle",
    init = function()
      vim.keymap.set("n", "<Leader>C", "<Cmd>MinimapToggle<CR>")
    end,
  },
}
