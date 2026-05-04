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

    context = ./config/CLAUDE.md;

    settings = {
      alwaysThinkingEnabled = true;

      enabledPlugins = {
        "cc-skills-golang@samber" = true;
        "code-review@claude-plugins-official" = true;
        "code-simplifier@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
        "github@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "superpowers@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
      };
      extraKnownMarketplaces = {
        samber = {
          source = {
            repo = "samber/cc";
            source = "github";
          };
        };
      };
      env = {
        CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
        CLAUDE_CODE_USE_VERTEX = "1";
        ENABLE_LSP_TOOL = "1";
      };
      includeCoAuthoredBy = true;
    };
  };
}
