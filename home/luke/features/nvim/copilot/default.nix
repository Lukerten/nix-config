{pkgs, ...}: {
  imports = [
    ./avante.nix
  ];

  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
      };
    };
    extraPackages = with pkgs; [nodejs-slim];
  };
}
