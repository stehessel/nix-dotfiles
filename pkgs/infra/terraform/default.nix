{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      terraform
      terragrunt
      terraform-ls
    ];
  };
}
