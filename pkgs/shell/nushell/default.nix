_: {
  programs.nushell = {
    enable = true;
    configFile = {
      text = ''
        let-env config = {
          edit_mode: vi
          show_banner: false
        }
      '';
    };
  };
}
