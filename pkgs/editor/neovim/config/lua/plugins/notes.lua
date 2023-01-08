return {
  {
    "vhyrro/neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader>n",
            },
          },
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = {
              tags = {
                my_workspace = "~/doc/neorg",
              },
            },
          },
        },
      })
    end,
    ft = "norg",
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
