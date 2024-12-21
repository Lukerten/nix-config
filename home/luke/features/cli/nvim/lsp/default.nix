{pkgs, ...}: {
  imports = [./lspconfig.nix ./null-ls.nix ./trouble.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    lspkind-nvim
    nvim-jdtls
    phpactor
    coc-tailwindcss
    tailwindcss-colors-nvim
    ltex_extra-nvim
  ];
}
