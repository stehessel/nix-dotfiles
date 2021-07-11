return {
  lintCommand = "selene --display-style quiet -",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %trror%m", "%f:%l:%c: %tarning%m" },
  prefix = "selene",
}
