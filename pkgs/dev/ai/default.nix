{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      claude-code
    ];
    sessionVariables = {
      CLAUDE_CODE_USE_VERTEX = "1";
    };
  };
}
