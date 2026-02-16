_: {
  programs.claude-code = {
    enable = true;

    commandsDir = ./config/commands;

    # mcpServers = {
    #   filesystem = {
    #     args = [
    #       "-y"
    #       "@modelcontextprotocol/server-filesystem"
    #       "/tmp"
    #     ];
    #     command = "npx";
    #     type = "stdio";
    #   };
    #   github = {
    #     type = "http";
    #     url = "https://api.githubcopilot.com/mcp/";
    #   };
    # };

    memory.source = ./config/CLAUDE.md;

    settings = {
      alwaysThinkingEnabled = true;
      includeCoAuthoredBy = true;
    };
  };

  home.sessionVariables = {
    CLAUDE_CODE_USE_VERTEX = "1";
  };
}
