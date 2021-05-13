return {
  lintCommand = "spectral lint --format=text ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {"%f:%l:%c %trror %m", "%f:%l:%c %tarning %m", "%f:%l:%c %tnfo %m"},
  lintSource = "spectral",
}
