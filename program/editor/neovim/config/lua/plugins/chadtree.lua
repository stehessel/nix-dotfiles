require("vimp")
require("core.settings")

vimp.nnoremap({"silent"}, ",e", ":CHADopen --nofocus<cr>")

vim.g.chadtree_settings = {
  keymap = {
    primary = {"<enter>", "h", "l"},
    select = {"<space>", "s"},
    h_split = {"V", "W"},
    v_split = {"v", "w"},
  },
  options = {show_hidden = false},
  theme = {text_colour_set = "solarized_light"},
  ignore = {
    name_glob = {".*"},
    name_exact = {
      ".DS_Store",
      ".directory",
      ".git",
      ".idea",
      ".mypy_cache",
      ".ropeproject",
      ".vim",
      ".vscode",
      "__pycache__",
      "dask-worker-space",
      "thumbs.db",
    },
  },
}
