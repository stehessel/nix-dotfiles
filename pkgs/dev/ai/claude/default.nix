{llms, ...}: {
  home = {
    packages = with llms; [
      ccstatusline
    ];
  };

  programs.claude-code = {
    enable = true;

    commandsDir = ./config/commands;

    mcpServers = {
      atlassian = {
        type = "http";
        url = "https://mcp.atlassian.com/v1/mcp";
      };
    };

    context = ./config/CLAUDE.md;

    settings = {
      alwaysThinkingEnabled = true;
      enabledPlugins = {
        "agent-eval-harness@opendatahub-skills" = true;
        "cc-skills-golang@samber" = true;
        "code-review@claude-plugins-official" = true;
        "code-simplifier@claude-plugins-official" = true;
        "context7@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "superpowers@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
      };
      extraKnownMarketplaces = {
        opendatahub-skills = {
          source = {
            repo = "opendatahub-io/skills-registry";
            source = "github";
          };
        };
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
      statusLine = {
        command = "npx -y ccstatusline@latest";
        padding = 0;
        refreshInterval = 10;
        type = "command";
      };
    };
  };
}
