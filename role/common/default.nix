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
    # ../../dev/haskell/hie
    ../../dev/haskell/stack
    ../../dev/javascript/npm
    ../../dev/python/conda
    ../../dev/python/flake8
    ../../dev/python/isort
    ../../dev/python/mypy
    # ../../dev/python/packages
    ../../dev/python/pdb
    ../../dev/python/pycodestyle
    ../../dev/version-control/git
    ../../dev/version-control/tig
    ../../program/backup/restic
    ../../program/editor/kakoune
    ../../program/editor/neovim
    ../../program/editor/coc
    ../../program/file-manager/lf
    ../../program/file-manager/vifm
    # ../../program/package-manager/nix
    ../../program/shell/bash
    ../../program/shell/bobthefish
    ../../program/shell/fish
    ../../program/shell/starship
    ../../program/terminal/alacritty
    ../../program/terminal/kitty
    ../../program/terminal/screen
    ../../program/terminal/tmux
    ../../program/todo/tasklite
    ../../program/todo/taskwarrior
    ../../program/utility/broot
    ../../program/utility/espanso
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
    # azure-cli
    # --- backup ---
    restic
    # --- clojure ---
    clojure
    clojure-lsp
    jdk11
    leiningen
    # --- cpp ---
    ccls
    # clang
    gdb
    # --- data ---
    jq
    # visidata
    # --- dev ---
    editorconfig-core-c
    pgformatter
    tokei
    universal-ctags
    xsv
    # --- docker ---
    # docker-sync
    # unison
    fswatch
    # --- editor ---
    neovim-remote
    # --- encryption ---
    gnupg
    # --- file manager ---
    lf
    vifm
    # --- file search ---
    # broot
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
    hack-font
    # nerdfonts
    # --- fuzzy search ---
    fzf
    skim
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitAndTools.hub
    tig
    # --- go ---
    go
    # --- haskell ---
    # cabal-install
    # ghc
    # stack
    # --- highlighters ---
    bat
    exa
    highlight
    # --- http ---
    # http-prompt
    # httpie
    # --- javascript ---
    nodejs-14_x
    yarn
    # --- launcher ---
    entr
    just
    pueue
    # --- lua ---
    luajitPackages.lua-lsp
    luajitPackages.luarocks
    # --- network ---
    bandwhich
    speedtest-cli
    # --- nix ---
    # arion
    # cachix
    lorri
    niv
    # nox
    pypi2nix
    rnix-lsp
    # --- plotting ---
    gnuplot
    # --- process manager ---
    htop
    procs
    # --- rust ---
    rustup
    rust-analyzer
    # --- ruby ---
    # ruby
    # --- shell ---
    bash_5
    dash
    fish
    starship
    # --- todo manager ---
    taskwarrior
    # --- terminal multiplexers ---
    screen
    tmux
    # --- utility ---
    direnv
    du-dust
    file
    gawk
    hyperfine
    jrnl
    neofetch
    svgcleaner
    topgrade
    wget
  ];
}
