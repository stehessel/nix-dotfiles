local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
  install_info = {
    url = "https://github.com/vhyrro/tree-sitter-norg",
    files = { "src/parser.c" },
    branch = "main",
  },
}

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "g.",
      node_incremental = "i",
      node_decremental = "o",
      scope_incremental = "u",
      scope_decremental = "d",
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
  indent = { entable = true },
  matchup = { enable = true },
  autotag = {
    enable = true,
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["df"] = "@function.outer",
        ["dF"] = "@class.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      keymaps = {
        ["ai"] = "@block.outer",
        ["ii"] = "@block.inner",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ak"] = "@comment.outer",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ad"] = "@parameter.outer",
        ["id"] = "@parameter.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
      },
    },
    swap = {
      enable = true,
      swap_previous = { ["g<"] = "@parameter.inner" },
      swap_next = { ["g>"] = "@parameter.inner" },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  ensure_installed = "maintained",
})
