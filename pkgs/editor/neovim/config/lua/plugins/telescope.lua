return {
  {
    "nvim-lua/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          color_devicons = true,
          scroll_strategy = "cycle",
          prompt_prefix = "❯ ",
          selection_caret = "❯ ",
          mappings = { i = { ["<Esc>"] = require("telescope.actions").close } },
        },
      })
      telescope.load_extension("advanced_git_search")
      telescope.load_extension("fzf")
      telescope.load_extension("gh")
      telescope.load_extension("neoclip")
      telescope.load_extension("project")
      telescope.load_extension("ui-select")
    end,
    init = function()
      vim.keymap.set("n", "<Leader>ff", "<Cmd>lua require('telescope.builtin').find_files()<CR>")
      vim.keymap.set("n", "<Leader>fr", "<Cmd>lua require('telescope.builtin').resume()<CR>")
      vim.keymap.set("n", "<Leader>fl", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
      vim.keymap.set("n", "<Leader>fL", "<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
      vim.keymap.set("n", "<Leader>fb", "<Cmd>lua require('telescope.builtin').buffers()<CR>")
      vim.keymap.set("n", "<Leader>fh", "<Cmd>lua require('telescope.builtin').oldfiles()<CR>")
      vim.keymap.set("n", "<Leader>fm", "<Cmd>lua require('telescope.builtin').marks()<CR>")
      vim.keymap.set("n", "<Leader>fc", "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>")
      vim.keymap.set("n", "<Leader>fv", "<Cmd>lua require('telescope.builtin').git_status()<CR>")
      vim.keymap.set("n", "<Leader>fg", "<Cmd>lua require('telescope.builtin').git_branches()<CR>")
      vim.keymap.set("n", "<Leader>fk", "<Cmd>lua require('telescope.builtin').keymaps()<CR>")
      vim.keymap.set("n", "<Leader>fs", "<Cmd>lua require('telescope.builtin').symbols()<CR>")
      vim.keymap.set("n", "<Leader>fo", "<Cmd>lua require('telescope.builtin').project()<CR>")
      vim.keymap.set("n", "<Leader>O", "<Cmd>lua require('telescope.builtin').spell_suggest()<CR>")

      vim.keymap.set(
        "n",
        "<Leader>fG",
        "<Cmd>lua require('telescope').extensions.advanced_git_search.show_custom_functions()<CR>"
      )

      vim.keymap.set("n", "<Leader>dc", "<Cmd>lua require('telescope').extensions.dap.commands({})<CR>")
      vim.keymap.set("n", "<Leader>db", "<Cmd>lua require('telescope').extensions.dap.list_breakpoints({})<CR>")
      vim.keymap.set("n", "<Leader>df", "<Cmd>lua require('telescope').extensions.dap.frames({})<CR>")
      vim.keymap.set("n", "<Leader>dv", "<Cmd>lua require('telescope').extensions.dap.variables({})<CR>")

      vim.keymap.set("n", "<Leader>fi", "<Cmd>lua require('telescope').extensions.gh.issues()<CR>")
      vim.keymap.set("n", "<Leader>fp", "<Cmd>lua require('telescope').extensions.gh.pull_request()<CR>")

      vim.keymap.set("n", "<Leader>y", "<Cmd>lua require('telescope').extensions.neoclip.neoclip()<CR>")

      vim.keymap.set("n", "<Leader>fy", "<Cmd>lua require('telescope').extensions.yaml_schema.yaml_schema()<CR>")

      vim.keymap.set("n", "gd", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
      vim.keymap.set("n", "gr", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>")
      vim.keymap.set("n", "gy", "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
      vim.keymap.set("n", "<Space>a", "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
      vim.keymap.set("x", "<Space>a", "<Cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>")
      vim.keymap.set("n", "<Space>o", "<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
      vim.keymap.set("n", "<Space>s", "<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>")
      vim.keymap.set("n", "<Space>e", "<Cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>")
    end,
    dependencies = {
      { "aaronhallaert/ts-advanced-git-search.nvim" },
      { "nvim-telescope/telescope-dap.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-github.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-symbols.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
	enabled = false,
  },
  {
    "folke/todo-comments.nvim",
    cmd = "TodoTelescope",
    config = function()
      require("todo-comments").setup({})
    end,
    init = function()
      vim.keymap.set("n", "<Leader>ft", "<Cmd>TodoTelescope<CR>")
    end,
  },
}
