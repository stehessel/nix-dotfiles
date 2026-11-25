let
  email = "shesselm@redhat.com";
  sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDfCZtbZxoqmVjxBItsKYitFZ07uVC6B9SSb37UC9GTu shesselm@redhat.com";
in {
  programs.git.settings.user = {
    inherit email;
    name = "Stephan Heßelmann";
    signingKey = "key::${sshPublicKey}";
  };
  programs.fish.shellAbbrs = {
    sm = "$HOME/go/src/github.com/openshift/release/hack/secret-manager.sh";
  };
  home = {
    file.".ssh/allowed_signers".text = ''
      ${email} ${sshPublicKey}
    '';
    sessionPath = [
      "$HOME/go/src/github.com/stackrox/workflow/bin"
    ];
  };
}
