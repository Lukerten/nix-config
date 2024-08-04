{pkgs, ...}: let
  lazygit-package = pkgs.vimPlugins.lazygit-nvim;

  lazygit-config =
    # lua
    ''
      vim.keymap.set("n", "<space>l", "<cmd>LazyGit<cr>", {desc="Open LazyGit"})
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = lazygit-package;
      type = "lua";
      config = lazygit-config;
    }
  ];
}
