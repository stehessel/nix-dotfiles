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
    ../../modules/shell/nushell
    ../../modules/shell/starship
    ../../modules/terminal/kitty
    ../../modules/terminal/tmux
    ../../modules/todo/taskwarrior
    ../../modules/utility/broot
    ../../modules/utility/fzf
    ../../modules/utility/gnupg
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
      LEIN_HOME = "${config.xdg.configHome}/lein";
      LIB_SQLITE_PATH =
        if pkgs.stdenv.isDarwin then
          "${pkgs.sqlite.out}/lib/libsqlite3.dylib"
        else
          "${pkgs.sqlite.out}/lib/libsqlite3.so";
      MINIKUBE_HOME = "${config.xdg.configHome}";
      PAGER = "less";
      PYTHONSTARTUP = "${config.xdg.configHome}/python/config";
      READER = "zathura";
      RUSTUP_HOME = "${config.xdg.configHome}/rustup";
      TERMINAL = "kitty";
      TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.configHome}/tmux/plugins";
      WGETRC = "${config.xdg.configHome}/wget/config";
    };
    # Needed for nvim-spectre on macOS
    shellAliases = {
      gsed = "sed";
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
    # --- chat ---
    zulip-term
    # --- clojure ---
    clojure
    # clojure-lsp
    leiningen
    # --- cloud ---
    azure-cli
    azure-storage-azcopy
    google-cloud-sdk
    # --- containers ---
    pkgs.podman-compose
    # --- data ---
    jq
    nodePackages.vscode-langservers-extracted
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
    ctop
    hadolint
    nodePackages.dockerfile-language-server-nodejs
    podman
    qemu
    # --- editor ---
    helix
    kakoune
    neovim
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
    # --- highlighters ---
    bat
    exa
    glow
    highlight
    # --- images ---
    exiftool
    # --- infrastructure ---
    ansible
    ansible-lint
    # --- java ---
    maven
    # --- javascript ---
    nodePackages.eslint_d
    nodejs-17_x
    nodePackages.typescript
    nodePackages.typescript-language-server
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
    k9s
    kube-linter
    kubectl
    kubectx
    kubernetes-helm
    minikube
    ocm
    odo
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
    # --- shell ---
    dash
    elvish
    nodePackages.bash-language-server
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
    # topgrade
    wget
    # --- web ---
    hugo
    nodePackages."@tailwindcss/language-server"
    # --- yaml ---
    yaml-language-server
  ];
}
