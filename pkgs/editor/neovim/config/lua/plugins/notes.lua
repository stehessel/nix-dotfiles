return {
  {
    "vhyrro/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    lazy = false,
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
            neorg_leader = "<Leader>n",
          },
        },
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              home = "~/doc/notes/home",
              todo = "~/doc/notes/todo",
            },
          },
        },
      },
    },
  },
  {
    "kristijanhusak/orgmode.nvim",
    config = function()
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup({
        org_agenda_files = { "~/doc/org/*" },
        org_default_notes_file = "~/doc/org/refile.org",
      })
    end,
    enabled = false,
  },
  { "habamax/vim-asciidoctor", ft = "asciidoctor" },
}
