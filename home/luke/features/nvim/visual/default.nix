{
  imports = [
    ./mini
    ./snacks
    ./alpha.nix
    ./bufferline.nix
    ./gitsigns.nix
    ./indent-blankline.nix
    ./inline-diagnostic.nix
    ./leap.nix
    ./lightbulb.nix
    ./lspsaga.nix
    ./lualine.nix
    ./noice.nix
    ./notify.nix
    ./nvim-tree.nix
    ./nvim-ufo.nix
    ./trouble.nix
    ./which-key.nix
  ];
  programs.nixvim = {
    plugins = {
      comment-box.enable = true;
      todo-comments.enable = true;
      web-devicons.enable = true;
      quicker.enable = true;
    };

    extraConfigLua =
      # lua
      ''
        vim.wo.fillchars='eob: '
        vim.opt.fillchars='eob: '
      '';
  };
}
