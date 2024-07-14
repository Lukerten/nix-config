{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = nvim-tree-lua;
    type = "lua";
    config = # lua
      ''
        require'nvim-tree'.setup{
          disable_netrw = false,
          hijack_netrw = true,
          open_on_tab = false,
          system_open = {
            cmd = '${pkgs.xdg-utils}/bin/xdg-open',
          },
          diagnostics = {
            enable = true,
          },
          update_cwd = true,
          view  = {
            width = 40,
            side = "left",
            number = false,
            relativenumber = false,
          },
          renderer = {
            indent_markers = {
              enable = true,
            },
            add_trailing = true,
            group_empty = true,
            highlight_git = true,
            root_folder_modifier = ":t",
          },
          hijack_directories = {
            enable = true,
            auto_open = true,
          },
          update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
          },
          actions = {
            use_system_clipboard = true,
            change_dir = {
              enable = true,
            },
            open_file = {
              quit_on_open = true,
              resize_window = false,
            },
          },
          git = {
            enable = true,
            ignore = false,
          },
          filters = {
            dotfiles = false,
          },
        }
      '';
  }];
}
