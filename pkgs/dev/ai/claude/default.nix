_: {
  programs.claude-code = {
    enable = true;

    commandsDir = ./config/commands;

    mcpServers = {
      # filesystem = {
      #   args = [
      #     "-y"
      #     "@modelcontextprotocol/server-filesystem"
      #     "/tmp"
      #   ];
      #   command = "npx";
      #   type = "stdio";
      # };
      # github = {
      #   type = "http";
      #   url = "https://api.githubcopilot.com/mcp/";
      # };
    };

    memory.source = ./config/CLAUDE.md;

    settings = {
      alwaysThinkingEnabled = true;
      enabledPlugins = {
        "code-review@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "superpowers@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
      };
      env = {
        ENABLE_LSP_TOOL = "1";
      };
      includeCoAuthoredBy = true;
    };
  };

  home.sessionVariables = {
    CLAUDE_CODE_USE_VERTEX = "1";
  };
}
