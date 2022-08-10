{ config, lib, pkgs, ... }:
{
  imports = [
    ../../pkgs/backup/restic
    ../../pkgs/dev/golang
    ../../pkgs/dev/javascript
    ../../pkgs/dev/jsonnet
    ../../pkgs/dev/lua
    ../../pkgs/dev/python
    ../../pkgs/dev/rust
    ../../pkgs/dev/secrets
    ../../pkgs/dev/text/cbfmt
    ../../pkgs/dev/text/vale
    ../../pkgs/dev/version-control/git
    ../../pkgs/editor/neovim
    ../../pkgs/file-manager/lf
    ../../pkgs/networking/kubernetes
    ../../pkgs/shell/bash
    ../../pkgs/shell/fish
    ../../pkgs/shell/nushell
    ../../pkgs/shell/starship
    ../../pkgs/terminal/tmux
    ../../pkgs/todo/taskwarrior
    ../../pkgs/utility/broot
    ../../pkgs/utility/fzf
    ../../pkgs/utility/gnupg
    # ../../pkgs/utility/pueue
    ../../pkgs/utility/ripgrep
    ../../pkgs/utility/topgrade
    ../../pkgs/utility/wget
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
      JIRA_AUTH_TYPE = "bearer";
      LEIN_HOME = "${config.xdg.configHome}/lein";
      LIB_SQLITE_PATH =
        if pkgs.stdenv.isDarwin then
          "${pkgs.sqlite.out}/lib/libsqlite3.dylib"
        else
          "${pkgs.sqlite.out}/lib/libsqlite3.so";
      PAGER = "less";
      READER = "zathura";
      SHELL = "";
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
      jira-cli-go
      prometheus
      tokei
      tree-sitter
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
      # --- network ---
      bandwhich
      curl
      grpcurl
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
      nodePackages.sql-formatter
      sqlite
      # --- system ---
      (uutils-coreutils.override { prefix = ""; })
      # --- terminal multiplexers ---
      tmux
      # --- terraform ---
      terraform
      terraform-ls
      # --- text ---
      asciidoctor
      # --- utility ---
      bitwarden-cli
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
      hugo
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
