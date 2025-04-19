{
  config,
  lib,
  ...
}:
with lib; let
  hasCopilotChat = config.programs.nixvim.plugins.copilot-chat.enable;
  hasAvante = config.programs.nixvim.plugins.avante.enable;
  mkOpts = desc: {
    inherit desc;
    silent = true;
    noremap = true;
  };
in {
  programs.nixvim.keymaps =
    optionals hasAvante []
    ++ optionals hasCopilotChat [
      {
        mode = "n";
        key = "<leader>c";
        action = "<cmd>CopilotChat<CR>";
        options = mkOpts "Copilot Chat";
      }
    ];
}
