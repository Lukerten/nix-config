{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-notify;
      type = "lua";
      config =
        #lua
        ''
          require("notify").setup {
            stages = "fade",
            timeout = 5000,
            background_colour = "#000000",
            icons = {
              ERROR = "",
              WARN = "",
              INFO = "",
              DEBUG = "",
              TRACE = "",
            },
            level = vim.log.levels.WARN,
            minimum_width = 50,
            render = "default",
            stages = "fade_in_slide_out",
            time_formats = {
              notification = "%T",
              notification_history = "%FT%T"
            },
            timeout = 2000,
            top_down = true
          }
          vim.notify = require('notify')
        '';
    }
  ];
}
