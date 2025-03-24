{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./completions
    ./core
    ./lsp
    ./utils
    ./visuals
  ];

  home.packages = with pkgs; [lazygit xclip];
  programs.neovim.enable = true;
  programs.pvim.enable = true;
}
