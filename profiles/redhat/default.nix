{
  programs.git.settings.user = {
    email = "shesselm@redhat.com";
    name = "Stephan Heßelmann";
    signingKey = "~/.ssh/id_ed25519.pub";
  };
  home = {
    sessionPath = [
      "$HOME/go/src/github.com/stackrox/workflow/bin"
    ];
    sessionVariables = {
      ANTHROPIC_VERTEX_PROJECT_ID = "itpc-gcp-hcm-pe-eng-claude";
      CLOUD_ML_REGION = "global";
    };
  };
}
