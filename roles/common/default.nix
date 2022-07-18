{ config, lib, pkgs, ... }:
{
  imports = [
    ../../modules/backup/restic
    ../../modules/dev/clojure/leiningen
    ../../modules/dev/golang
    ../../modules/dev/javascript
    ../../modules/dev/jsonnet
    ../../modules/dev/lua
    ../../modules/dev/python
    ../../modules/dev/rust
    ../../modules/dev/text/vale
    ../../modules/dev/version-control/git
    ../../modules/editor/neovim
    ../../modules/file-manager/lf
    ../../modules/shell/bash
    ../../modules/shell/fish
    # ../../modules/shell/nushell
    ../../modules/shell/starship
    ../../modules/terminal/kitty
    ../../modules/terminal/tmux
    ../../modules/todo/taskwarrior
    # ../../modules/utility/broot
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
    stateVersion = "22.11";
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
      PAGER = "less";
      READER = "zathura";
      SHELL = "";
      TERMINAL = "kitty";
      TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.configHome}/tmux/plugins";
    };
    shellAliases = {
      less = "less -i -R";
    };

    packages = with pkgs; [
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
      google-cloud-sdk
      # --- containers ---
      # pkgs.podman-compose
      # --- data ---
      jq
      nodePackages.vscode-langservers-extracted
      yq-go
      # --- desktop ---
      xdg-utils
      # --- dev ---
      buf
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
      # podman
      qemu
      # --- editor ---
      helix
      kakoune
      # --- file manager ---
      lf
      nnn
      # --- file search ---
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
      pre-commit
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
      # --- launcher ---
      pueue
      # --- kubernetes ---
      k9s
      krew
      kube-linter
      kubectl
      # kubectx
      kubernetes-helm
      ocm
      odo
      openshift
      operator-sdk
      # --- network ---
      bandwhich
      curl
      netcat
      ngrok
      nmap
      speedtest-cli
      # --- nix ---
      cachix
      nix-prefetch-github
      nix-update
      nixpkgs-fmt
      rnix-lsp
      statix
      # --- process manager ---
      htop
      # --- shell ---
      bashInteractive
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
      duf
      file
      gettext
      hyperfine
      sd
      topgrade
      wget
      # --- web ---
      # hugo  # blocked by macOS SDK > 10.12
      nodePackages."@tailwindcss/language-server"
      # --- yaml ---
      yaml-language-server
    ];
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
}
