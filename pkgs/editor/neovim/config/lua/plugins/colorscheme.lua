return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    build = ":CatppuccinCompile",
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      require("catppuccin").setup({
        compile = {
          enabled = true,
        },
        integrations = {
          leap = true,
          neotree = {
            enabled = true,
            show_root = true,
            transparent_panel = false,
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
    lazy = false,
  },
}
