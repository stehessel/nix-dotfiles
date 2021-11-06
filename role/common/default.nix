{ config, lib, pkgs, ... }:
let
  sources = import ../../nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [
    ../../dev/build-system/just-build
    ../../dev/clojure/leiningen
    # ../../dev/haskell/hie
    ../../dev/haskell/stack
    ../../dev/javascript/npm
    ../../dev/lua/luacheck
    ../../dev/lua/luaformatter
    ../../dev/lua/stylua
    ../../dev/python/conda
    ../../dev/python/flake8
    ../../dev/python/isort
    ../../dev/python/mypy
    # ../../dev/python/packages
    ../../dev/python/pdb
    # ../../dev/python/pip
    ../../dev/python/pycodestyle
    ../../dev/rust/cargo
    ../../dev/text/vale
    ../../dev/version-control/git
    ../../program/backup/restic
    ../../program/editor/kakoune
    ../../program/editor/neovim
    ../../program/file-manager/lf
    # ../../program/package-manager/nix
    ../../program/shell/bash
    ../../program/shell/bobthefish
    ../../program/shell/fish
    ../../program/terminal/alacritty
    ../../program/terminal/kitty
    ../../program/terminal/screen
    ../../program/terminal/tmux
    ../../program/terminal/wezterm
    ../../program/todo/tasklite
    ../../program/todo/taskwarrior
    ../../program/utility/broot
    # ../../program/utility/espanso
    # ../../program/utility/file
    # ../../program/utility/pueue
    ../../program/utility/ripgrep
    ../../program/utility/topgrade
    ../../script
  ];

  # home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # home.sessionVariables = {
  #   LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };

  home.packages = with pkgs; [
    # --- azure ---
    azure-cli
    azure-storage-azcopy
    # --- backup ---
    rclone
    restic
    # --- clojure ---
    clojure
    clojure-lsp
    # jdk11
    leiningen
    # --- cpp ---
    ninja
    # --- data ---
    jq
    yq
    # --- dev ---
    editorconfig-core-c
    pgformatter
    tree-sitter
    tokei
    universal-ctags
    xsv
    # ---  docker ---
    act
    hadolint
    # --- editor ---
    kakoune
    neovim
    neovim-remote
    # --- encryption ---
    gnupg
    # --- file manager ---
    lf
    nnn
    # --- file search ---
    broot
    fd
    ripgrep
    tre-command
    # --- file transfer ---
    rsync
    # --- file viewer ---
    pandoc
    # --- font ---
    fira-code
    font-awesome
    # --- fuzzy search ---
    fzf
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitAndTools.hub
    gitui
    # --- highlighters ---
    bat
    exa
    highlight
    # --- http ---
    http-prompt
    httpie
    # --- java ---
    maven
    # --- javascript ---
    nodejs-16_x
    yarn
    # --- launcher ---
    just
    pueue
    # --- lua ---
    luajitPackages.lua-lsp
    luajitPackages.luacheck
    luajitPackages.luarocks
    # --- network ---
    bandwhich
    netcat
    speedtest-cli
    # --- nix ---
    cachix
    niv
    nixpkgs-fmt
    rnix-lsp
    # --- process manager ---
    htop
    # --- rust ---
    rustup
    rust-analyzer
    # --- ruby ---
    # ruby_2_7
    # --- shell ---
    bash_5
    dash
    fish
    shellcheck
    shfmt
    # --- terminals ---
    # wezterm
    # --- terminal multiplexers ---
    tmux
    # --- text ---
    asciidoctor
    # --- todo manager ---
    taskwarrior
    # --- utility ---
    direnv
    du-dust
    file
    hyperfine
    topgrade
    wget
    # --- watcher ---
    watchman
    # --- web ---
    hugo
  ];
}
