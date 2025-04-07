{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./completions
    ./copilot
    ./core
    ./lsp
    ./telescope
    ./treesitter
    ./utils
    ./visuals
  ];

  home.sessionVariables.COLORTERM = "truecolor";
  home.sessionVariables.EDITOR = lib.getExe pkgs.neovim;

  home.packages = with pkgs; [xclip];
  programs.neovim.enable = true;
  programs.pvim.enable = true;
}
