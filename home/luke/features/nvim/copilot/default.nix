{pkgs, ...}: {
  imports = [
    ./avante.nix
    ./keymap.nix
  ];
  programs.nixvim = {
    plugins = {
      copilot-lua.enable = true;
      copilot-chat.enable = true;
      render-markdown = {
        enable = true;
        lazyLoad.settings = {
          ft = [
            "copilot-chat"
          ];
        };
        settings = {
          file_types = [
            "copilot-chat"
          ];
        };
      };
    };

    extraPackages = with pkgs; [nodejs-slim];
  };
}
