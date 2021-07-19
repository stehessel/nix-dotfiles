local helpers = require("null-ls.helpers")

return helpers.make_builtin({
  method = require("null-ls.methods").internal.FORMATTING,
  filetypes = { "fish" },
  generator_opts = {
    command = "fish_indent",
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
})