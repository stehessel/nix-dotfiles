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
    ../../dev/version-control/tig
    ../../program/backup/restic
    ../../program/editor/kakoune
    ../../program/editor/neovim
    ../../program/file-manager/lf
    ../../program/file-manager/vifm
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
    # azure-cli
    azure-storage-azcopy
    # --- backup ---
    rclone
    restic
    # --- clojure ---
    clojure
    # clojure-lsp
    # jdk11
    leiningen
    # --- cpp ---
    ccls
    ninja
    # clang
    gdb
    # --- data ---
    jq
    visidata
    yq
    # --- dev ---
    editorconfig-core-c
    pgformatter
    tokei
    universal-ctags
    xsv
    # ---  docker ---
    hadolint
    # --- editor ---
    kakoune
    neovim
    neovim-remote
    # --- encryption ---
    gnupg
    # --- file manager ---
    lf
    # vifm
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
    fzy
    skim
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitAndTools.hub
    lazygit
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
    http-prompt
    httpie
    # --- java ---
    maven
    # --- javascript ---
    nodejs-15_x
    yarn
    # --- launcher ---
    entr
    just
    pueue
    # --- lua ---
    luajitPackages.lua-lsp
    luajitPackages.luacheck
    luajitPackages.luarocks
    # --- network ---
    bandwhich
    speedtest-cli
    # --- nix ---
    arion
    cachix
    # lorri
    niv
    rnix-lsp
    # --- notes ---
    neuron-notes
    # --- plotting ---
    gnuplot
    # --- process manager ---
    htop
    # procs
    # --- rust ---
    rustup
    # rust-analyzer
    # --- ruby ---
    # ruby_2_7
    # --- shell ---
    bash_5
    dash
    fish
    shellcheck
    shfmt
    # --- ssh ---
    sshpass
    # --- terminals ---
    # wezterm
    # --- terminal multiplexers ---
    tmux
    # --- text ---
    asciidoctor
    vale
    # --- todo manager ---
    taskwarrior
    # --- utility ---
    direnv
    du-dust
    file
    gawk
    hyperfine
    jrnl
    neofetch
    svgcleaner
    # topgrade
    wget
    # --- watcher ---
    watchman
    # --- web ---
    hugo
  ];
}
