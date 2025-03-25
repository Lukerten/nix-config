{pkgs, ...}: {
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

  home.packages = with pkgs; [lazygit xclip];
  programs.neovim.enable = true;
  programs.pvim.enable = true;
}
