{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../pkgs/backup
    ../../pkgs/cloud
    ../../pkgs/container
    ../../pkgs/dev
    ../../pkgs/editor/neovim
    ../../pkgs/file-manager/lf
    ../../pkgs/infra
    ../../pkgs/networking
    ../../pkgs/productivity
    ../../pkgs/security
    ../../pkgs/shell
    ../../pkgs/terminal/tmux
    ../../pkgs/utility
    ../../scripts
  ];

  xdg.enable = true;

  home = {
    stateVersion = "22.11";
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
    ];
    sessionVariables = {
      BOTO_CONFIG = "${config.xdg.configHome}/boto/config";
      EDITOR = "nvim";
      FILE = "lf";
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      LEIN_HOME = "${config.xdg.configHome}/lein";
      LIB_SQLITE_PATH =
        if pkgs.stdenv.isDarwin
        then "${pkgs.sqlite.out}/lib/libsqlite3.dylib"
        else "${pkgs.sqlite.out}/lib/libsqlite3.so";
      PAGER = "less";
      READER = "zathura";
      SHELL = "";
      TMUX_PLUGIN_MANAGER_PATH = "${config.xdg.configHome}/tmux/plugins";
    };
    shellAliases = {
      less = "less -i -R";
    };

    packages = with pkgs; [
      # --- desktop ---
      xdg-utils
      # --- dev ---
      code-minimap
      codespell
      editorconfig-core-c
      mimir
      prometheus
      prometheus-alertmanager
      tokei
      tree-sitter
      universal-ctags
      xsv
      # --- editor ---
      helix
      # kakoune
      # --- file manager ---
      nnn
      xplr
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
      eza
      glow
      highlight
      # --- images ---
      exiftool
      # --- java ---
      maven
      # --- network ---
      bandwhich
      curl
      grpcurl
      httpie
      jwt-cli
      netcat
      nmap
      speedtest-cli
      # --- process manager ---
      htop
      # --- system ---
      # (uutils-coreutils.override {prefix = "";})
      # --- terminal ---
      # alacritty
      # --- terminal multiplexers ---
      tmux
      # --- utility ---
      cmatrix
      du-dust
      duf
      file
      gettext
      hyperfine
      sd
      watch
      wget
      # --- web ---
      hugo
    ];
  };

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
