return {
  {
    "AndrewRadev/switch.vim",
    cmd = "Switch",
    init = function()
      vim.g.switch_mapping = ""
      vim.keymap.set("n", "-", "<Cmd>Switch<CR>")
    end,
  },
  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
    init = function()
      vim.keymap.set({ "n", "x" }, "ga", ":EasyAlign<CR>")
    end,
  },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    ft = { "clojure", "fennel" },
    dependencies = {
      {
        "guns/vim-sexp",
        config = function()
          vim.g.sexp_enable_insert_mode_mappings = 0
        end,
      },
    },
  },
  { "matze/vim-move", event = "BufReadPre" },
  { "mg979/vim-visual-multi", keys = { "<C-n>", "<C-Up>", "<C-Down>" } },
  {
    "nicwest/vim-camelsnek",
    cmd = { "Camel", "CamelB", "Kebab", "Snek" },
    init = function()
      vim.keymap.set({ "n", "x" }, "<Leader>xs", "<Cmd>Snek<CR>")
      vim.keymap.set({ "n", "x" }, "<Leader>xc", "<Cmd>Camel<CR>")
      vim.keymap.set({ "n", "x" }, "<Leader>xb", "<Cmd>CamelB<CR>")
      vim.keymap.set({ "n", "x" }, "<Leader>xk", "<Cmd>Kebab<CR>")
    end,
  },
  { "tpope/vim-repeat", keys = "." },
  {
    "sQVe/sort.nvim",
    cmd = "Sort",
    config = function()
      require("sort").setup({})
    end,
    init = function()
      vim.keymap.set("n", "go", "<Cmd>Sort<CR>")
      vim.keymap.set("v", "go", "<Esc><Cmd>Sort<CR>")
    end,
  },
  -- Increment / Decrement
  {
    "monaqa/dial.nvim",
    init = function()
      vim.keymap.set({ "n", "x" }, "<C-a>", "<Plug>(dial-increment)")
      vim.keymap.set({ "n", "x" }, "<C-x>", "<Plug>(dial-decrement)")
      vim.keymap.set("n", "g<C-a>", "<Plug>(dial-increment-additional)")
      vim.keymap.set("n", "g<C-x>", "<Plug>(dial-decrement-additional)")
    end,
    keys = {
      "<Plug>(dial-increment)",
      "<Plug>(dial-decrement)",
      "<Plug>(dial-increment-additional)",
      "<Plug>(dial-decrement-additional)",
    },
  },
  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    event = "BufReadPre",
  },
  -- Text substitution
  {
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup({})
    end,
    init = function()
      -- Substitute
      vim.keymap.set(
        "n",
        "<Leader>s",
        "<Cmd>lua require('substitute').operator()<CR>",
        { desc = "Substitute with motion", noremap = true }
      )
      vim.keymap.set(
        "n",
        "<Leader>ss",
        "<Cmd>lua require('substitute').line()<CR>",
        { desc = "Substitute line", noremap = true }
      )
      vim.keymap.set(
        "n",
        "<Leader>sl",
        "<Cmd>lua require('substitute').eol()<CR>",
        { desc = "Substitute to end of line", noremap = true }
      )
      vim.keymap.set(
        "x",
        "<Leader>s",
        "<Cmd>lua require('substitute').visual()<CR>",
        { desc = "Substitute selection", noremap = true }
      )

      -- Exchange
      vim.keymap.set(
        "n",
        "<Leader>sx",
        "<Cmd>lua require('substitute.exchange').operator()<CR>",
        { desc = "Exchange with motion", noremap = true }
      )
      vim.keymap.set(
        "n",
        "<Leader>sxx",
        "<Cmd>lua require('substitute.exchange').line()<CR>",
        { desc = "Substitute line", noremap = true }
      )
      vim.keymap.set(
        "x",
        "<Leader>X",
        "<Cmd>lua require('substitute.exchange').visual()<CR>",
        { desc = "Exchange selected", noremap = true }
      )
      vim.keymap.set(
        "n",
        "<Leader>sxc",
        "<Cmd>lua require('substitute.exchange').cancel()<CR>",
        { desc = "Cancel exchange", noremap = true }
      )
    end,
  },
  -- Text objects
  { "wellle/targets.vim", event = "BufReadPre" },
  { "gcmt/taboo.vim", event = "BufReadPre" },
}
