{pkgs, ...}: {
  imports = [./lspconfig.nix ./none-ls.nix ./trouble.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    lspkind-nvim
    nvim-jdtls
    phpactor
    coc-tailwindcss
    tailwindcss-colors-nvim
    ltex_extra-nvim
  ];
}
