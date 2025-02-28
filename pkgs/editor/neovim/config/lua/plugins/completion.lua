return {
  {
    "saghen/blink.cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "disrupted/blink-cmp-conventional-commits" },
      {
        "Kaiser-Yang/blink-cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    event = "InsertEnter",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = { enabled = false },
      keymap = { preset = "enter" },
      signature = { enabled = true },
      sources = {
        default = { "conventional_commits", "git", "lsp", "path", "snippets", "buffer" },
        providers = {
          conventional_commits = {
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
            module = "blink-cmp-conventional-commits",
            name = "Conventional Commits",
            ---@module 'blink-cmp-conventional-commits'
            ---@type blink-cmp-conventional-commits.Options
            opts = {},
          },
          git = {
            module = "blink-cmp-git",
            name = "Git",
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            opts = {},
          },
        },
      },
    },
    opts_extend = { "sources.default" },
    version = "*",
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        hint_enable = false,
        handler_opts = { border = "none" },
      })
    end,
    enabled = false,
  },
}
