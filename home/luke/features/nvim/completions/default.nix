{
  pkgs,
  lib,
  ...
}: {
  imports = [./copilot.nix ./snippets.nix ./vim-cmp.nix];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    otter-nvim
    cmp-buffer
    cmp-nvim-lsp
    cmp_luasnip
    cmp-vsnip
    cmp-path
    {
      plugin = cmp-git;
      type = "lua";
      config =
        # lua
        ''
          require("cmp_git").setup({})
        '';
    }
  ];
}
