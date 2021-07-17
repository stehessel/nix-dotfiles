local helpers = require("null-ls.helpers")

local opts = {
  command = "fish_indent",
  to_stdin = true,
}

return helpers.make_builtin({
  method = require("null-ls.methods").internal.DIAGNOSTICS,
  filetypes = { "fish" },
  generator_opts = opts,
  factory = helpers.formatter_factory,
})
