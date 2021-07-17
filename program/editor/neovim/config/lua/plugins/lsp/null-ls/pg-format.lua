local helpers = require("null-ls.helpers")

return helpers.make_builtin({
  method = require("null-ls.methods").internal.FORMATTING,
  filetypes = { "sql" },
  generator_opts = {
    command = "pg_format",
    args = { "-" },
    to_stdin = true,
  },
  factory = helpers.formatter_factory,
})
