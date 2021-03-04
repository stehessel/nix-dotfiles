local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

require("telescope").setup({
  defaults = {
    prompt_position = "top",
    prompt_prefix = "🔍 ",
    sorting_strategy = "ascending",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--ignore-case",
    },
  },
})
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("gh")
require("telescope").load_extension("vimspector")

require("vimp")
vimp.nnoremap({"silent"}, "<leader>ff", builtin.find_files)
vimp.nnoremap({"silent"}, "<leader>fg", builtin.live_grep)
vimp.nnoremap({"silent"}, "<leader>fl", builtin.current_buffer_fuzzy_find)
vimp.nnoremap({"silent"}, "<leader>fb", builtin.buffers)
vimp.nnoremap({"silent"}, "<leader>fh", builtin.oldfiles)
vimp.nnoremap({"silent"}, "<leader>fm", builtin.marks)
vimp.nnoremap({"silent"}, "<leader>fc", builtin.git_bcommits)
vimp.nnoremap({"silent"}, "<leader>fk", builtin.keymaps)
vimp.nnoremap({"silent"}, "<leader>fi", require("telescope").extensions.gh.issues)
vimp.nnoremap({"silent"}, "<leader>fp", require("telescope").extensions.gh.pull_request)
vimp.nnoremap({"silent"}, "<leader>fd",
  require("telescope").extensions.vimspector.configurations)
vimp.nnoremap({"silent"}, "<leader>fr", function()
  require"telescope.builtin".lsp_references {shorten_path = true}
end)
