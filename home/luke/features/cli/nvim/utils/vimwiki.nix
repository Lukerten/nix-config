{pkgs, ...}:{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.vimwiki;
      type = "lua";
      config =
        #lua
        ''
          vim.g.vimwiki_list = {{
            path = '~/Wiki',
            syntax = 'markdown',
            ext = 'md',
            diary_rel_path = 'private/Diary'
          }}
          vim.api.nvim_set_keymap("n", "<leader>w", ":VimwikiIndex<CR>", default_opts("Open Wiki"))
        '';
    }
  ];
}
