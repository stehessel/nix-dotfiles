local helpers = require("null-ls.helpers")

local opts = {
  command = "codespell",
  args = { "$FILENAME" },
  format = "line",
  on_output = function(line, _)
    local row, msg = line:match(":(%d+): (.*)")
    return {
      row = row,
      col = 1,
      message = msg,
      severity = 3,
    }
  end,
  to_stderr = true,
}

return helpers.make_builtin({
  method = require("null-ls.methods").internal.DIAGNOSTICS,
  filetypes = { "*" },
  generator_opts = opts,
  factory = helpers.generator_factory,
})
