{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [
    ../../dev/clojure/leiningen
    ../../dev/javascript/npm
    ../../dev/lua/luacheck
    ../../dev/lua/luaformatter
    ../../dev/lua/stylua
    ../../dev/python/conda
    ../../dev/python/flake8
    ../../dev/python/isort
    ../../dev/python/mypy
    # ../../dev/python/packages
    # ../../dev/python/pip
    ../../dev/python/pycodestyle
    ../../dev/rust/cargo
    ../../dev/text/vale
    ../../dev/version-control/git
    ../../program/backup/restic
    ../../program/editor/neovim
    ../../program/file-manager/lf
    ../../program/package-manager/nix
    ../../program/shell/bash
    ../../program/shell/bobthefish
    ../../program/shell/fish
    ../../program/terminal/alacritty
    ../../program/terminal/kitty
    ../../program/terminal/tmux
    ../../program/todo/taskwarrior
    ../../program/utility/broot
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
    yq-go
    # --- dev ---
    cmake
    code-minimap
    codespell
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
    # neovim
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
    fzy
    # --- git ---
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitAndTools.hub
    gitui
    # --- golang ---
    delve
    ginkgo
    go_1_17
    golangci-lint
    gopls
    gotest
    gotestsum
    richgo
    # --- highlighters ---
    bat
    exa
    glow
    highlight
    # --- http ---
    http-prompt
    httpie
    # --- infrastructure ---
    ansible
    # --- javascript ---
    nodejs-17_x
    yarn
    # --- launcher ---
    pueue
    # --- lua ---
    luajitPackages.lua-lsp
    luajitPackages.luacheck
    luajitPackages.luarocks
    selene
    stylua
    sumneko-lua-language-server
    # --- kubernetes ---
    kube-linter
    kubectl
    kubectx
    kubernetes-helm
    # --- network ---
    bandwhich
    curl
    netcat
    nmap
    speedtest-cli
    # --- nix ---
    cachix
    nix-prefetch-github
    nixUnstable
    nixpkgs-fmt
    rnix-lsp
    statix
    # --- process manager ---
    htop
    # --- python ---
    python39Packages.black
    python39Packages.isort
    python39Packages.pipx
    pyright
    # --- rust ---
    rustup
    rust-analyzer
    # --- ruby ---
    # ruby_2_7
    # --- shell ---
    dash
    shellcheck
    shfmt
    # --- sql ---
    sqlite
    # --- system ---
    (uutils-coreutils.override { prefix = ""; })
    # --- terminals ---
    # wezterm
    # --- terminal multiplexers ---
    tmux
    # --- terraform ---
    terraform
    terraform-ls
    # --- text ---
    asciidoctor
    # --- todo manager ---
    taskwarrior
    # --- utility ---
    cmatrix
    du-dust
    file
    hyperfine
    topgrade
    wget
    # --- watcher ---
    watchman
    # --- web ---
    hugo
    # --- yaml ---
    yaml-language-server
  ];
}
