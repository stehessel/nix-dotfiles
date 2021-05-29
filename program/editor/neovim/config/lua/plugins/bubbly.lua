vim.opt.showmode = false

vim.g.bubbly_statusline = {
  "mode",
  "truncate",
  "path",
  "builtinlsp.diagnostic_count",
  "builtinlsp.current_function",
  "divisor",
  "filetype",
  "progress",
}
vim.g.bubbly_tags = {
  filetype = {
    noft = "", -- If it's empty the bubble disappears
  },
}
vim.g.bubbly_palette = {
  background = "#34343c",
  foreground = "#c5cdd9",
  black = "#3e4249",
  red = "#ec7279",
  green = "#a0c980",
  yellow = "#deb974",
  blue = "#6cb6eb",
  purple = "#d38aea",
  cyan = "#5dbbc1",
  white = "#c5cdd9",
  lightgrey = "#57595e",
  darkgrey = "#404247",
}
vim.g.bubbly_styles = {
  mode = "bold",
  path = { readonly = "bold", unmodifiable = "", path = "", modified = "" },
  branch = "bold",
  paste = "bold",
}
vim.g.bubbly_symbols = {
  builtinlsp = { diagnostic_count = { error = "Errors: %s", warning = "Warnings: %s" } },
}
