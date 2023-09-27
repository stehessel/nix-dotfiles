{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jira-cli-go
    ];
    sessionVariables = {
      JIRA_AUTH_TYPE = "bearer";
    };
  };
}
