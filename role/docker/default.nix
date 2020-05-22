{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    # ../../dev/python/packages
    ../../dev/version-control/git
    ../../dev/version-control/tig
    ../../program/editor/kakoune
    ../../program/editor/neovim
    ../../program/editor/coc
    ../../program/file-manager/lf
    ../../program/file-manager/vifm
    ../../program/shell/fish
    ../../program/shell/starship
    ../../program/utility/broot
    ../../program/utility/file
    ../../program/utility/ripgrep
    ../../script
  ];

  xdg.configFile."nix/nix-single-user.fish".source = config/nix-single-user.fish;
  xdg.configFile."fish/fishfile".source = ../../program/shell/fish/linux/fishfile;
  xdg.configFile."bobthefish/config.fish".source = ../../program/shell/bobthefish/docker/config.fish;

  home.packages = with pkgs; [
    # --- azure ---
    azure-cli
    # --- dev ---
    jq
    tig
    tokei
    universal-ctags
    xsv
    # --- editor ---
    neovim
    neovim-remote
    # --- file manager ---
    lf
    vifm
    # --- file search ---
    broot
    fd
    ripgrep
    tre-command
    # --- file viewer ---
    pandoc
    # --- fuzzy search ---
    fzf
    skim
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.git-bug
    gitAndTools.hub
    # --- highlighters ---
    bat
    exa
    highlight
    # --- network ---
    bandwhich
    speedtest-cli
    # --- process manager ---
    htop
    # --- shell ---
    dash
    fish
    starship
    # --- utility ---
    direnv
    du-dust
    file
    hyperfine
    neofetch
    svgcleaner
    topgrade
    wget
  ];
}
