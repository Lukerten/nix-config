{pkgs, ...}: {
  imports = [./lspconfig.nix ./null-ls.nix ./trouble.nix];

  programs.neovim.plugins = [
    pkgs.vimPlugins.lspkind-nvim
    pkgs.vimPlugins.nvim-jdtls
    pkgs.vimPlugins.phpactor
    pkgs.vimPlugins.coc-tailwindcss
    pkgs.vimPlugins.tailwindcss-colors-nvim
    pkgs.vimPlugins.ltex_extra-nvim
  ];
}
