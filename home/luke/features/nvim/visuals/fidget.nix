{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = fidget-nvim;
    type = "lua";
    config = # lua
      ''
        local fidget = require('fidget')
        fidget.setup({
          progress = {
            ignore_done_already = true,
            ignore_empty_message = true,
          },
          display = {
            render_limit = 8,
            done_ttl = 1,
            done_icon = '✓',
            done_style = 'Constant',
          },
          notification = {
            poll_rate = 10,
            filter = vim.log.levels.WARN,
            history_size = 128,
            override_vim_notify = true,
          },
        })
      '';
  }];
}
