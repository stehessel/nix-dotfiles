return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "vhyrro/neorg",
    dependencies = { "luarocks.nvim" },
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
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.concealer"] = {},
        ["core.dirman"] = {
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
