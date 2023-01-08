return {
  {
    "kassio/neoterm",
    cmd = { "T", "Texec", "Tmap", "Tnew", "Topen", "Ttoggle" },
    config = function()
      vim.g.neoterm_autoinsert = 1
      vim.g.neoterm_default_mod = "rightbelow vertical"
      vim.g.neoterm_shell = "fish"
    end,
    init = function()
      vim.keymap.set("n", "<Leader>Tt", ":Ttoggle<cr>")
      vim.keymap.set("n", "<Leader>Tr", ":TREPLSetTerm<cr>")
      vim.keymap.set("n", "<Leader>Tf", ":TREPLSendFile<cr>")
      vim.keymap.set("n", "<Leader>Tl", ":TREPLSendLine<cr>")
      vim.keymap.set("x", "<Leader>Tl", ":TREPLSendSelection<cr>")
      vim.keymap.set({ "n", "x" }, "gx", "<Plug>neoterm-repl-send")
    end,
  },
  {
    "numtostr/FTerm.nvim",
    config = function()
      vim.keymap.set("n", "<Leader>G", function()
        local gitui = require("FTerm"):new({
          cmd = "gitui",
          dimensions = {
            height = 0.9,
            width = 0.9,
          },
        })
        gitui:toggle()
      end)
    end,
    keys = { "<Leader>G" },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup()
    end,
  },
  {
    "Olical/conjure",
    config = function()
      vim.g["conjure#log#hud#width"] = 0.42
    end,
    ft = { "clojure", "fennel" },
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    init = function()
      vim.keymap.set("n", "<Leader>nr", "<Cmd>lua require('sniprun').run()<CR>")
      vim.keymap.set("x", "<Leader>nr", "<Cmd>lua require('sniprun').run('v')<CR>")
      vim.keymap.set("n", "<Leader>nc", "<Cmd>lua require('sniprun.display').close_all()<CR>")
      vim.keymap.set("n", "<Leader>nx", "<Cmd>lua require('sniprun').reset()<CR>")
      vim.keymap.set("n", "<Leader>ni", "<Cmd>lua require('sniprun').info()<CR>")
    end,
    event = "BufReadPre",
  },
}
