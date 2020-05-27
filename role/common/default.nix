{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
    ../../program/utility/file
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
    # --- cpp ---
    ccls
    # clang
    gdb
    # --- data ---
    jq
    visidata
    # --- dev ---
    editorconfig-core-c
    tokei
    universal-ctags
    xsv
    # --- docker ---
    # docker-sync
    unison
    fswatch
    # --- editor ---
    neovim-remote
    # --- encryption ---
    gnupg
    # --- file manager ---
    lf
    vifm
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
    hack-font
    # nerdfonts
    # --- fuzzy search ---
    fzf
    skim
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.git-bug
    gitAndTools.hub
    tig
    # --- go ---
    go
    # --- haskell ---
    # cabal-install
    ghc
    stack
    # --- highlighters ---
    bat
    exa
    highlight
    # --- javascript ---
    nodejs-13_x
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
    cachix
    lorri
    niv
    nox
    pypi2nix
    # --- plotting ---
    gnuplot
    # --- process manager ---
    htop
    # procs
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
    ansible
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
