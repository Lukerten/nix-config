{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) colors harmonized;
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config =
        # lua
        ''
          local generatedTheme = {
            normal = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.blue}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },

            insert = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.green}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },

            visual = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.magenta}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },

            replace = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.red}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },

            command = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.yellow}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },

            inactive = {
              gui = 'bold',
              a = { fg = '${colors.surface}', bg = '${harmonized.blue}'},
              b = { fg = '${colors.on_surface}', bg = '${colors.surface_variant}'},
              c = { fg = '${colors.on_surface}', bg = '${colors.surface}'},
            },
          }

          require'lualine'.setup {
            options = {
              icons_enabled = false,
              theme = generatedTheme,
              disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" , "Trouble" },
              always_divide_middle = true,
              component_separators = {
                left = "⏽",
                right = "⏽"
              },
              section_separators = {
                left = "",
                right = ""
              },
            },
            sections = {
              lualine_a = { 'mode' },
              lualine_b = { 'branch', 'diff'},
              lualine_c = {'filename'},
              lualine_x = {
                {
                  "diagnostics",
                  sources = {'nvim_lsp'},
                  symbols = {error = '', warn = '', info = '', hint = ''},
                },
                "filetype",
                "encoding",
              },
              lualine_y = {'progress'},
              lualine_z = {'location'},
            },
            inactive_sections = {
              lualine_a = { mode },
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {},
              lualine_y = {},
              lualine_z = {},
            },
            tabline = {},
            extensions = {},
          }
        '';
    }
  ];
}
