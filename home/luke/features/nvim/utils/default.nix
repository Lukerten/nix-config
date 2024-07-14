{ pkgs, ... }: {
  imports = [
    ./alpha.nix
    ./bufferline.nix
    ./gx.nix
    ./nvim-tree.nix
    ./oil.nix
    ./statusline.nix
    ./toggleterm.nix
  ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    nui-nvim
    popup-nvim
    vim-illuminate
    nvim-notify
    {
      plugin = vim-bbye;
      type = "lua";
      config = # lua
        ''
          vim.keymap.set("n", "<C-d>", "<cmd>Bdelete<cr>", {desc="Close buffer"});
        '';
    }
    {
      plugin = todo-comments-nvim;
      type = "lua";
      config = # lua
        ''
          require("todo-comments").setup {}
        '';
    }
    {
      plugin = markdown-preview-nvim;
      type = "lua";
      config = # lua
        "";
    }
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config =
        # lua
        ''
          require('colorizer').setup{}
        '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config =
        # lua
        ''
          require('nvim-web-devicons').setup{}
        '';
    }
    {
      plugin = nvim-bqf;
      type = "lua";
      config =
        # lua
        ''
          require('bqf').setup{}
        '';
    }
    {
      plugin = scope-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('scope').setup{}
        '';
    }
    {
      plugin = which-key-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('which-key').setup{}
        '';
    }
    {
      plugin = range-highlight-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('range-highlight').setup{}
        '';
    }
    {
      plugin = indent-blankline-nvim;
      type = "lua";
      config =
        # lua
        ''
          require('ibl').setup{
            scope = { highlight = {"IndentBlankLine"} },
            indent = { highlight = {"IndentBlankLine"} },
          }
        '';
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = # lua
        ''
          require('nvim-web-devicons').setup{}
        '';
    }
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config =
        # lua
        ''
          require('colorizer').setup{}
        '';
    }
    {
      plugin = kommentary;
      type = "lua";
      config = # lua
        ''
          require("kommentary.config").configure_language("default", {
            prefer_single_line_comments = true,
            use_consistent_indentation = true,
            ignore_whitespace = true,
          })
        '';
    }
    {
      plugin = todo-comments-nvim;
      type = "lua";
      config = # lua
        ''
          require("todo-comments").setup {}
        '';
    }
    {
      plugin = noice-nvim;
      type = "lua";
      config = # lua
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
            },
            presets = {
              bottom_search = true,
              command_palette = true,
              long_message_to_split = true,
              inc_rename = false,
              lsp_doc_border = false,
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
