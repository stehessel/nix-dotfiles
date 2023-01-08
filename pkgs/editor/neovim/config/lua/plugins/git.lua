return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "+",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "*",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "-",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
        },
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,

          ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
          },
          ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
          },

          ["n <leader>hs"] = '<cmd>lua require("gitsigns").stage_hunk()<CR>',
          ["n <leader>hu"] = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
          ["n <leader>hr"] = '<cmd>lua require("gitsigns").reset_hunk()<CR>',
          ["n <leader>hR"] = '<cmd>lua require("gitsigns").reset_buffer()<CR>',
          ["n <leader>hh"] = '<cmd>lua require("gitsigns").preview_hunk()<CR>',
          ["n <leader>hb"] = '<cmd>lua require("gitsigns").blame_line(true)<CR>',
          ["n <leader>hv"] = '<cmd>lua require("gitsigns").toggle_linehl()<CR>',

          -- Text objects
          ["o ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
          ["x ih"] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
        },
      })
    end,
  },
  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_ignored_filetypes = { "neo-tree" }
    end,
    init = function()
      vim.keymap.set("n", "<Leader>B", "<Cmd>GitBlameToggle<CR>")
    end,
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    init = function()
      vim.keymap.set("n", "<Leader>m", "<cmd>GitMessenger<CR>")
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = function()
      require("octo").setup()
    end,
  },
}
