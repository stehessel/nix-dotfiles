local helpers = require("null-ls.helpers")

local opts = {
  command = "flake8",
  args = { "--max-line-length", "100", "-" },
  on_output = function(line, _)
    local row, col, msg = line:match(":(%d+):(%d+): (.*)")
    return {
      row = row,
      col = col,
      message = msg,
      severity = 1,
      source = "flake8",
    }
  end,
  format = "line",
  to_stdin = true,
  to_stderr = true,
}

return helpers.make_builtin({
  method = require("null-ls.methods").internal.DIAGNOSTICS,
  filetypes = { "python" },
  generator_opts = opts,
  factory = helpers.generator_factory,
})
