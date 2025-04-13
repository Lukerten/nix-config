{
  imports = [
    ./alpha.nix
    ./barbar.nix
    ./diffview.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./inline-diagnostic.nix
    ./leap.nix
    ./lualine.nix
    ./neoscroll.nix
    ./noice.nix
    ./notify.nix
    ./nvim-tree.nix
    ./trouble.nix
    ./which-key.nix
  ];
  programs.nixvim = {
    plugins = {
      todo-comments.enable = true;
      web-devicons.enable = true;
    };

    extraConfigLua =
      # lua
      ''
        vim.wo.fillchars='eob: '
        vim.opt.fillchars='eob: '
      '';
  };
}
