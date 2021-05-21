return {
  lintCommand = "hadolint --no-color -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = {
    "%f:%l %s%n %trror: %m",
    "%f:%l %s%n %tarning: %m",
    "%f:%l %s%n %tnfo: %m",
    "%f:%l %s%n %tote: %m",
  },
  lintSource = "hadolint",
}
