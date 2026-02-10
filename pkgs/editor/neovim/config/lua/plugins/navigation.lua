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
    event = "VeryLazy",
  },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    init = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

      vim.keymap.set({ "n", "o" }, "gs", function()
        require("leap.remote").action({
          -- Automatically enter Visual mode when coming from Normal.
          input = vim.fn.mode(true):match("o") and "" or "v",
        })
      end)
      -- Forced linewise version (`gS{leap}jjy`):
      vim.keymap.set({ "n", "o" }, "gS", function()
        require("leap.remote").action({ input = "V" })
      end)

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress
      -- (`:h leap.opts.preview`). You can still target any visible
      -- positions if needed, but you can define what is considered an
      -- exceptional case.
      -- Exclude whitespace and the middle of alphabetic words from preview:
      --   foobar[baaz] = quux
      --   ^----^^^--^^-^-^--^
      require("leap").opts.preview = function(ch0, ch1, ch2)
        return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
      end

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      require("leap").opts.equivalence_classes = {
        " \t\r\n",
        "([{",
        ")]}",
        "'\"`",
      }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
    end,
  },
  {
    "ggandor/flit.nvim",
    init = function()
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
    init = function()
      require("leap-spooky").setup()
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
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
