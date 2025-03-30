return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      vim.keymap.set("n", "<Leader>ff", require("fzf-lua").files)
      vim.keymap.set("n", "<Leader>fh", require("fzf-lua").oldfiles)
      vim.keymap.set("n", "<Leader>fl", require("fzf-lua").live_grep_native)
      vim.keymap.set("n", "<Leader>fr", require("fzf-lua").resume)
      vim.keymap.set("n", "<Leader>fm", require("fzf-lua").marks)
      vim.keymap.set("n", "<Leader>fp", require("fzf-lua").profiles)

      vim.keymap.set("n", "<Leader>fC", require("fzf-lua").git_commits)
      vim.keymap.set("n", "<Leader>fb", require("fzf-lua").git_branches)
      vim.keymap.set("n", "<Leader>fc", require("fzf-lua").git_bcommits)
      vim.keymap.set("n", "<Leader>fg", require("fzf-lua").git_status)

      vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions)
      vim.keymap.set("n", "gr", require("fzf-lua").lsp_references)
      vim.keymap.set("n", "gy", require("fzf-lua").lsp_implementations)
      vim.keymap.set("n", "<Space>a", require("fzf-lua").lsp_code_actions)
      vim.keymap.set("n", "<Space>o", require("fzf-lua").lsp_document_symbols)
      vim.keymap.set("n", "<Space>s", require("fzf-lua").lsp_workspace_symbols)
      vim.keymap.set("n", "<Space>e", require("fzf-lua").lsp_workspace_diagnostics)
    end,
    opts = {},
  },
}
