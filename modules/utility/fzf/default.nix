{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    fzf_fd_opts = "--type=file";
    fzf_preview_dir_cmd = "exa --all --color=always --group-directories-first";
  };

  programs = {
    fzf = {
      enable = true;
      defaultOptions = [
        "--border"
        "--cycle"
        "--height 85%"
        "--info=inline"
        "--layout=reverse"
        "--preview-window=wrap"
      ];
    };
  };
}
