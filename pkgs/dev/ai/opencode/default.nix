{...}: {
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    settings = {
      lsp = {
        gopls = {
          command = ["gopls" "serve"];
          extensions = [".go"];
        };
        nixd = {
          command = ["nixd"];
          extensions = [".nix"];
        };
        yaml-ls = {
          disabled = false;
        };
      };
    };
  };
}
