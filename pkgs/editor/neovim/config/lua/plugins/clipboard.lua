return {
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup({
        -- Disabled because it caused start up to hang up to 30 seconds.
        enable_persistent_history = false,
        default_register = "+",
      })
      vim.g.sqlite_clib_path = os.getenv("LIB_SQLITE_PATH")
    end,
    dependencies = {
      { "ibhagwan/fzf-lua" },
      { "kkharji/sqlite.lua", module = "sqlite" },
    },
    event = "VeryLazy",
    init = function()
      vim.keymap.set("n", "<Leader>y", require("neoclip.fzf"))
    end,
  },
}
