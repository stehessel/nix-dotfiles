{ config, lib, pkgs, ... }:
{
  imports = [
    ../../modules/dev/clojure/leiningen
    ../../modules/dev/golang
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
    ../../modules/shell/fish
    ../../modules/shell/starship
    ../../modules/terminal/kitty
    ../../modules/terminal/tmux
    ../../modules/todo/taskwarrior
    ../../modules/utility/broot
    ../../modules/utility/fzf
    # ../../modules/utility/file
    # ../../modules/utility/pueue
    ../../modules/utility/ripgrep
    ../../modules/utility/topgrade
    ../../modules/utility/wget
    ../../scripts
  ];

  xdg.enable = true;

  home = {
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.luarocks/bin"
      "$HOME/miniconda3/bin"
      "/usr/local/bin"
    ];
    sessionVariables = {
      BOTO_CONFIG = "${config.xdg.configHome}/boto/config";
      EDITOR = "nvim";
      FILE = "lf";
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      HISTFILE = "${config.xdg.dataHome}/fish/fish_history";
      LEIN_HOME = "${config.xdg.configHome}/lein";
      MINIKUBE_HOME = "${config.xdg.configHome}";
      PAGER = "less";
      PYTHONSTARTUP = "${config.xdg.configHome}/python/config";
      READER = "zathura";
      RUSTUP_HOME = "${config.xdg.configHome}/rustup";
      TERMINAL = "kitty";
      TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.configHome}/tmux/plugins";
      WGETRC = "${config.xdg.configHome}/wget/config";
      XDG_RUNTIME_DIR = "$TMPDIR";
    };
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };

  home.packages = with pkgs; [
    # --- backup ---
    rclone
    restic
    # --- clojure ---
    clojure
    # clojure-lsp
    leiningen
    # --- cloud ---
    # azure-cli
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
    helix
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
    tre-command
    # --- file transfer ---
    rsync
    # --- file viewer ---
    pandoc
    # --- font ---
    fira-code
    font-awesome
    # --- fuzzy search ---
    fzy
    # --- git ---
    gitAndTools.git-bug
    gitAndTools.git-fame
    gitui
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
    # --- java ---
    maven
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
    # kubectl
    kubectx
    kubernetes-helm
    minikube
    openshift
    # --- network ---
    bandwhich
    curl
    netcat
    nmap
    speedtest-cli
    # --- nix ---
    cachix
    nix-prefetch-github
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
    bashInteractive
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
