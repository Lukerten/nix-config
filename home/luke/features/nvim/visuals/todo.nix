{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) colors harmonized;
  todo-comments-package = pkgs.vimPlugins.todo-comments-nvim;
  todo-comments-config =
    # lua
    ''
      local todo_comments = require("todo-comments")
      todo_comments.setup {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority

        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = {
            icon = " ",
            color = "info"
          },
          HACK = {
            icon = " ",
            color = "warning"
          },
          WARN = {
            icon = " ",
            color = "warning",
            alt = { "WARNING", "XXX" }
          },
          PERF = {
            icon = " ",
            color = "hint",
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
          },
          NOTE = {
            icon = " ",
            color = "hint",
            alt = { "INFO" }
          },
          TEST = {
            icon = "⏲ ",
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" }
          },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true,
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error =   { "${harmonized.red}" },
          warning = { "${harmonized.yellow}" },
          info =    { "${harmonized.blue}" },
          hint =    { "${harmonized.green}" },
          default = { "${harmonized.cyan}" },
          test =    { "${harmonized.orange}" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      }
    '';
in {
  programs.neovim.plugins = [
    {
      plugin = todo-comments-package;
      type = "lua";
      config = todo-comments-config;
    }
  ];
}
