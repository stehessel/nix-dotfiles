require"nvim-treesitter.configs".setup {
  highlight = {enable = true},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gl",
      node_incremental = "i",
      node_decremental = "o",
      scope_incremental = "u",
      scope_decremental = "d",
    },
  },
  indent = {entable = true},
  refactor = {
    highlight_definitions = {enable = false},
    highlight_current_scope = {enable = false},
    smart_rename = {enable = true, keymaps = {smart_rename = "<leader>R"}},
    navigation = {
      enable = true,
      keymaps = {goto_definition = "gnd", list_definitions = "gnD"},
    },
  },
  textobjects = {
    enable = true,
    disable = {},
    keymaps = {
      ["iL"] = {
        -- you can define your own textobjects directly here
        python = "(function_definition) @function",
      },
      -- or you use the queries from supported languages with textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["aC"] = "@class.outer",
      ["iC"] = "@class.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["ae"] = "@block.outer",
      ["ie"] = "@block.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["is"] = "@statement.inner",
      ["as"] = "@statement.outer",
      ["ad"] = "@comment.outer",
      ["am"] = "@call.outer",
      ["im"] = "@call.inner",
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  ensure_installed = "all",
}
