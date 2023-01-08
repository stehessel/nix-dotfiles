return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap")
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

      require("dap").defaults.fallback.exception_breakpoints = { "raised", "uncaught" }

      require("telescope").load_extension("dap")
    end,
    init = function()
      vim.keymap.set("n", "<F2>", "<Cmd>lua require('dap').pause()<CR>")
      vim.keymap.set("n", "<F3>", "<Cmd>lua require('dap').require('dap').terminate()<CR>")
      vim.keymap.set("n", "<F4>", "<Cmd>lua require('dap').require('dap').restart()<CR>")
      vim.keymap.set("n", "<F5>", "<Cmd>lua require('dap').require('dap').continue()<CR>")
      vim.keymap.set("n", "<F6>", "<Cmd>lua require('dap').require('dap').up()<CR>")
      vim.keymap.set("n", "<F7>", "<Cmd>lua require('dap').require('dap').down()<CR>")
      vim.keymap.set("n", "<F8>", "<Cmd>lua require('dap').require('dap').run_to_cursor()<CR>")
      vim.keymap.set("n", "<F9>", "<Cmd>lua require('dap').toggle_breakpoint()<CR>")
      vim.keymap.set("n", "<Leader><F9>", function()
        require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
      end)
      vim.keymap.set("n", "<Localleader><F9>", function()
        require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end)
      vim.keymap.set("n", "<F10>", "<Cmd>lua require('dap').step_over()<CR>")
      vim.keymap.set("n", "<F11>", "<Cmd>lua require('dap').step_into()<CR>")
      vim.keymap.set("n", "<F12>", "<Cmd>lua require('dap').step_out()<CR>")
      vim.keymap.set("n", "<Leader>dr", "<Cmd>lua require('dap').repl.toggle<CR>")
      vim.keymap.set("n", "<Leader>dh", "<Cmd>lua require('dap.ui.widgets').hover()<CR>")
    end,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
          vim.keymap.set("n", "<Leader>du", require("dapui").toggle)
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          vim.g.dap_virtual_text = true
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("python", {})
          require("dap-python").test_runner = "pytest"
        end,
        ft = "python",
      },
      {
        "leoluz/nvim-dap-go",
        config = function()
          require("dap-go").setup()
        end,
        ft = "go",
      },
    },
  },
}
