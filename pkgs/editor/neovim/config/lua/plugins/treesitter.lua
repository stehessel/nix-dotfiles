return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = vim.cmd.TSUpdate,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "g.",
          },
        },
        textsubjects = {
          enable = true,
          prev_selection = ",",
          keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
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
              ["<Space>p"] = "@function.outer",
              ["<Space>P"] = "@class.outer",
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
              ["ik"] = "@comment.inner",
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
        markid = { enable = true },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
        },
        ensure_installed = "all",
      })
    end,
    dependencies = {
      { "David-Kunz/markid" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
      },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "windwp/nvim-ts-autotag" },
    },
    event = "VeryLazy",
  },
  {
    "ThePrimeagen/refactoring.nvim",
    init = function()
      vim.keymap.set("v", "<Leader>re", "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>")
      vim.keymap.set("v", "<Leader>rf", "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>")
      vim.keymap.set("v", "<Leader>rv", "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>")
      vim.keymap.set("v", "<Leader>ri", "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>")
    end,
    opts = {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
      },
    },
  },
}
