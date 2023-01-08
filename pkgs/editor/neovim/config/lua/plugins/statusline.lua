return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { disabled_filetypes = { "Calltree", "NvimTree", "packer", "terminal" } },
        sections = {
          lualine_c = { "filename" },
        },
      })
    end,
    dependencies = { { "arkav/lualine-lsp-progress" } },
    lazy = false,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
    lazy = false,
  },
}
