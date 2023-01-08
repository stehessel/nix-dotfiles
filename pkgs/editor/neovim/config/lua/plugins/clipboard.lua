return {
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup({ enable_persistent_history = true, default_register = "+" })
      vim.g.sqlite_clib_path = os.getenv("LIB_SQLITE_PATH")
    end,
    dependencies = { "tami5/sqlite.lua" },
  },
}
