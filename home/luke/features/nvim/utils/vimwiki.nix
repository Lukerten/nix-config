{
  pkgs,
  ...
}: let
  package = pkgs.vimPlugins.vimwiki;
  config = 
    #lua
    ''
      vim.g.vimwiki_list = {{
        path = '~/Wiki',
        syntax = 'markdown',
        ext = 'md',
        diary_rel_path = 'private/Diary'
      }}
      vim.api.nvim_set_keymap("n", "<space>w", ":VimwikiIndex<CR>", default_opts("Open Wiki"))
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = package;
      type = "lua";
      config = config;
    }
  ];
}
