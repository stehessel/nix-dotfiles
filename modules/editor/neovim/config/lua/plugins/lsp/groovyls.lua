return {
  setup = function(on_attach, capabilities, debounce_text_changes)
    require("lspconfig").groovyls.setup({
      cmd = {
        "java",
        "-jar",
        "/Users/stephan/program/groovy-language-server/build/libs/groovy-language-server-all.jar",
      },
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = function(fname)
        return require("lspconfig").util.root_pattern("Jenkinsfile")(fname)
          or require("lspconfig").util.root_pattern("gradlew")(fname)
          or require("lspconfig").util.find_git_ancestor(fname)
      end,
      flags = { debounce_text_changes = debounce_text_changes },
    })
  end,
}
