{llms, ...}: {
  programs.pi-coding-agent = {
    enable = true;
    package = llms.pi;
  };
}
