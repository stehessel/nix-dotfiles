return {
  {
    "nvim-neotest/neotest",
    config = function()
      -- Get neotest namespace (api call creates or returns namespace).
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
          }),
          require("neotest-plenary"),
          require("neotest-python")({
            dap = {
              justMyCode = true,
            },
          }),
        },
      })
    end,
    init = function()
      vim.keymap.set("n", "<Leader>tt", "<Cmd>lua require('neotest').run.run()<CR>")
      vim.keymap.set("n", "<Leader>tf", "<Cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
      vim.keymap.set("n", "<Leader>td", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>")
      vim.keymap.set("n", "<Leader>tl", "<Cmd>lua require('neotest').run.run_last()<CR>")
      vim.keymap.set("n", "<Leader>ta", "<Cmd>lua require('neotest').run.run({suite = true})<CR>")
      vim.keymap.set("n", "<Leader>tx", "<Cmd>lua require('neotest').run.stop()<CR>")
      vim.keymap.set("n", "<Leader>ts", "<Cmd>lua require('neotest').summary.toggle()<CR>")
      vim.keymap.set("n", "<Leader>tm", "<Cmd>lua require('neotest').summary.run_marked()<CR>")
      vim.keymap.set("n", "<Leader>to", "<Cmd>lua require('neotest').output.open()<CR>")
      vim.keymap.set("n", "<Leader>tp", "<Cmd>lua require('neotest').output_panel.toggle()<CR>")
      vim.keymap.set("n", "<Leader>tc", "<Cmd>lua require('neotest').output_panel.clear()<CR>")
    end,
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-python",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
