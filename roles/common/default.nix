{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  imports = [
    ../../modules/dev/clojure/leiningen
    ../../modules/dev/javascript/npm
    ../../modules/dev/lua/luacheck
    ../../modules/dev/lua/luaformatter
    ../../modules/dev/lua/stylua
    ../../modules/dev/python/conda
    ../../modules/dev/python/flake8
    ../../modules/dev/python/isort
    ../../modules/dev/python/mypy
    ../../modules/dev/python/python
    # ../../modules/dev/python/pip
    ../../modules/dev/python/pycodestyle
    ../../modules/dev/rust/cargo
    ../../modules/dev/text/vale
    ../../modules/dev/version-control/git
    ../../modules/backup/restic
    ../../modules/editor/neovim
    ../../modules/file-manager/lf
    ../../modules/shell/bash
    ../../modules/shell/bobthefish
    ../../modules/shell/fish
    ../../modules/terminal/alacritty
    ../../modules/terminal/kitty
    ../../modules/terminal/tmux
    ../../modules/todo/taskwarrior
    ../../modules/utility/broot
    # ../../modules/utility/file
    # ../../modules/utility/pueue
    ../../modules/utility/ripgrep
    ../../modules/utility/topgrade
    ../../modules/utility/wget
    ../../scripts
  ];

  # home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # home.sessionVariables = {
  #   LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  # };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    go = {
      enable = true;
      goPath = "go";
      package = pkgs.go_1_17;
    };
  };

  home.packages = with pkgs; [
    # --- backup ---
    rclone
    restic
    # --- clojure ---
    clojure
    clojure-lsp
    # jdk11
    leiningen
    # --- cloud ---
    azure-cli
    azure-storage-azcopy
    google-cloud-sdk
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
    neovim
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
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitui
    # --- golang ---
    delve
    ginkgo
    golangci-lint
    gopls
    gotest
    gotests
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
    minikube
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
