let
  email = "shesselm@redhat.com";
  sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfCZtbZxoqmVjxBItsKYitFZ07uVC6B9SSb37UC9GTu shesselm@redhat.com";
in {
  programs.git.settings.user = {
    inherit email;
    name = "Stephan Heßelmann";
    signingKey = "key::${sshPublicKey}";
  };
  home = {
    file.".ssh/allowed_signers".text = ''
      ${email} ${sshPublicKey}
    '';
    sessionPath = [
      "$HOME/go/src/github.com/stackrox/workflow/bin"
    ];
    sessionVariables = {
      ANTHROPIC_VERTEX_PROJECT_ID = "itpc-gcp-hcm-pe-eng-claude";
      CLOUD_ML_REGION = "global";
    };
  };
}
