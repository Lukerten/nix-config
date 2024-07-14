{ pkgs, ... }: {
  imports = [ ./gitsigns.nix ./lazygit.nix ];
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = vim-fugitive;
    type = "lua";
    config = # lua
      ''
        vim.keymap.set("n", "<space>Gf", "<cmd> Git<cr>", {desc="Git status", noremap=true, silent=true});
      '';
  }];
}
