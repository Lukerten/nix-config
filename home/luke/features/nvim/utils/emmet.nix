{
  pkgs,
  config,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = emmet-vim;
      type = "lua";
      config =
        # lua
        ''
          vim.g.user_emmet_mode = 'inv'
          vim.g.user_emmet_install_global = 0
          vim.g.user_emmet_leader_key = '<C-y>'

          vim.cmd([[
            autocmd FileType html,css,scss,xml,jsx,javascript EmmetInstall
          ]])
        '';
    }
  ];
}
