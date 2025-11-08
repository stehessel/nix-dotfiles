{pkgs, ...}: {
  hooks = {
    # Editor
    editorconfig-checker.enable = true;
    tagref.enable = true;

    # GitHub actions
    # actionlint.enable = true;

    # Misc
    prettier.enable = true;

    # Nix
    alejandra.enable = true;
    deadnix.enable = true;
    statix = {
      enable = true;
      settings.ignore = [".direnv" "**/hardware-configuration.nix"];
    };

    # Builtin pre-commit hooks
    check-merge-conflict = {
      enable = true;
      name = "check for merge conflicts";
      description = "checks for files that contain merge conflict strings.";
      entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/check-merge-conflict";
      language = "python";
      types = ["text"];
    };
    detect-private-key = {
      enable = true;
      name = "detect private key";
      description = "detects the presence of private keys.";
      entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/detect-private-key";
      language = "python";
      types = ["text"];
    };
  };
}
