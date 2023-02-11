{pkgs, ...}: {
  home = {
    sessionVariables = {
      JIRA_AUTH_TYPE = "bearer";
    };
    packages = with pkgs; [
      jira-cli-go
    ];
  };
}
