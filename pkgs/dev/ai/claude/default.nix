{
  config,
  lib,
  llms,
  pkgs,
  ...
}: let
  enmaasToken = config.sops.secrets."redhat/enmaas/token" or null;
  defaultModel = "claude-opus-4-6[1m]";
  enmaasModel = "rits/zai-org/glm-5-3";
  deepseekModel = "rits/deepseek-ai/DeepSeek-V4.1-Flash-1017";
in {
  home = {
    packages = with llms; [
      ccstatusline
    ];
  };

  programs.claude-code = {
    configDir = "${config.xdg.configHome}/claude";
    enable = true;
    enableMcpIntegration = true;
    package = llms.claude-code;

    commandsDir = ./config/commands;

    context = ./config/CLAUDE.md;

    settings = lib.mkMerge [
      (lib.mkIf (enmaasToken != null) {
        model = enmaasModel;
        apiKeyHelper = "${lib.getExe' pkgs.coreutils "cat"} ${lib.escapeShellArg enmaasToken.path}";
        env = {
          ANTHROPIC_BASE_URL = "https://api.enmaas.devshift.net";
          ANTHROPIC_DEFAULT_HAIKU_MODEL = enmaasModel;
          ANTHROPIC_DEFAULT_SONNET_MODEL = enmaasModel;
          ANTHROPIC_DEFAULT_OPUS_MODEL = enmaasModel;
          ANTHROPIC_DEFAULT_FABLE_MODEL = deepseekModel;
          CLAUDE_CODE_SUBAGENT_MODEL = enmaasModel;
          CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY = "1";
          CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
          CLAUDE_CODE_AUTO_MODE_SERVER = "0";
        };
        permissions.disableAutoMode = "disable";
        modelPicker.options = [
          {
            model = enmaasModel;
            label = "GLM 5.3";
            description = "Hosted via EnMaaS";
            behavesAs = "claude-opus-4-8";
          }
          {
            model = deepseekModel;
            label = "DeepSeek V4.1 Flash";
            description = "Hosted via EnMaaS";
            behavesAs = "claude-opus-4-8";
          }
        ];
        modelSettings = {
          claude-sonnet-5.effortLevel = "medium";
          claude-opus-4-8.effortLevel = "medium";
          ${enmaasModel}.effortLevel = "high";
          ${lib.toLower deepseekModel}.effortLevel = "high";
        };
      })
      {
        alwaysThinkingEnabled = true;
        model = lib.mkDefault defaultModel;
        enabledPlugins = {
          "agent-eval-harness@opendatahub-skills" = true;
          "cc-skills-golang@samber" = true;
          "code-review@claude-plugins-official" = true;
          "code-simplifier@claude-plugins-official" = true;
          "comprehensive-review@tag1consulting" = true;
          "context7@claude-plugins-official" = true;
          "gopls-lsp@claude-plugins-official" = true;
          "ponytail@ponytail" = true;
          "pr-review-toolkit@claude-plugins-official" = true;
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
          ponytail = {
            source = {
              repo = "DietrichGebert/ponytail";
              source = "github";
            };
          };
          samber = {
            source = {
              repo = "samber/cc";
              source = "github";
            };
          };
          tag1consulting = {
            source = {
              repo = "tag1consulting/claude-plugins";
              source = "github";
            };
          };
        };
        env = {
          CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
          ENABLE_LSP_TOOL = "1";
        };
        includeCoAuthoredBy = true;
        statusLine = {
          command = "npx -y ccstatusline@latest";
          padding = 0;
          refreshInterval = 10;
          type = "command";
        };
      }
    ];
  };
}
