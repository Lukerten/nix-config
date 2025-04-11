{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
      };

      copilot-chat = {
        enable = true;
        settings = {
          model = "claude-3.7-sonnet";
        };
      };
    };
    extraPackages = with pkgs; [nodejs-slim];
  };
}
