_: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        app-id = "foot";
        dpi-aware = "yes";
        shell = "fish";
        font = "FiraCode Nerd Font:size=7.5";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
