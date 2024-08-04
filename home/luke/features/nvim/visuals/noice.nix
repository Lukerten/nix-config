{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = noice-nvim;
      type = "lua";
      config =
        # lua
        ''
          require("noice").setup({
            lsp = {
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
              },
              signature = {
                enabled = false,
              },
              documentation = {
                view = "hover",
                opts = {
                  lang = "markdown",
                  replace = true,
                  render = "plain",
                  format = { "{message}" },
                  win_options = { concealcursor = "n", conceallevel = 3 },
                },
              },
            },
            markdown = {
              hover = {
                ["|(%S-)|"] = vim.cmd.help, -- vim help links
                ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
              },
              highlights = {
                ["|%S-|"] = "@text.reference",
                ["@%S+"] = "@parameter",
                ["^%s*(Parameters:)"] = "@text.title",
                ["^%s*(Return:)"] = "@text.title",
                ["^%s*(See also:)"] = "@text.title",
                ["{%S-}"] = "@parameter",
              },
            },
            health = {
              checker = true, -- Disable if you don't want health checks to run
            },
            commands ={
              history = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                opts = { enter = true, format = "details" },
                filter = {
                  any = {
                    { event = "notify" },
                    { error = true },
                    { warning = true },
                      { event = "msg_show", kind = { "" } },
                  { event = "lsp", kind = "message" },
                  },
                },
              },
              -- :Noice last
              last = {
                view = "popup",
                  opts = { enter = true, format = "details" },
                  filter = {
                    any = {
                      { event = "notify" },
                      { error = true },
                      { warning = true },
                      { event = "msg_show", kind = { "" } },
                      { event = "lsp", kind = "message" },
                    },
                  },
                filter_opts = { count = 1 },
              },
              -- :Noice errors
              errors = {
                -- options for the message history that you get with `:Noice`
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = { error = true },
                filter_opts = { reverse = true },
              },
              all = {
                -- options for the message history that you get with `:Noice`
                view = "split",
                  opts = { enter = true, format = "details" },
                  filter = {},
              },
            },
            notify = {
              enabled = true,
              view = "notify",
            },
            views = {
              cmdline_popup = {
                position = {
                  row = 5,
                  col = "50%",
                },
                size = {
                  width = 60,
                  height = "auto",
                },
              },
              popupmenu = {
                relative = "editor",
                position = {
                  row = 8,
                  col = "50%",
                },
                size = {
                  width = 60,
                  height = 10,
                },
                border = {
                  style = "rounded",
                  padding = { 0, 1 },
                },
                win_options = {
                  winhighlight = { Normal = "Normal", FloatBorder ="DiagnosticInfo" },
                },
              },
            },
          })
        '';
    }
  ];
}
