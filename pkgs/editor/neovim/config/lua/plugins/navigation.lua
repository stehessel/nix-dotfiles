return {
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        labeled_modes = "v",
        multiline = true,
        opts = {},
      })
    end,
  },
  {
    "ggandor/leap-spooky.nvim",
    config = function()
      require("leap-spooky").setup()
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    module = "tsht",
    init = function()
      vim.keymap.set("o", "m", ":<C-U>lua require('tsht').nodes()<CR>")
      vim.keymap.set("v", "m", "<Cmd>lua require('tsht').nodes()<CR>")
    end,
  },
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({})
    end,
    init = function()
      vim.keymap.set("n", "<C-h>", "<Cmd>lua require('Navigator').left()<CR>")
      vim.keymap.set("n", "<C-j>", "<Cmd>lua require('Navigator').down()<CR>")
      vim.keymap.set("n", "<C-k>", "<Cmd>lua require('Navigator').up()<CR>")
      vim.keymap.set("n", "<C-l>", "<Cmd>lua require('Navigator').right()<CR>")
      vim.keymap.set("n", "<C-p>", "<Cmd>lua require('Navigator').previous()<CR>")
    end,
  },
}
