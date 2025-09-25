{config, ...}: {
  programs.git = {
    userEmail = "shesselm@redhat.com";
    userName = "Stephan Heßelmann";
  };
  home = {
    sessionPath = [
      "$HOME/${config.programs.go.goPath}/src/github.com/stackrox/workflow/bin"
    ];
    sessionVariables = {
      ANTHROPIC_VERTEX_PROJECT_ID = "itpc-gcp-hybrid-pe-eng-claude";
      CLOUD_ML_REGION = "us-east5";
    };
  };
}
