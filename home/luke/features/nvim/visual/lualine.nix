{config, ...}: let
  hasDevicons = config.programs.nixvim.plugins.web-devicons.enable;
in {
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
        iconsEnabled = hasDevicons;
        disabled_filetypes = {
          __unkeyed-1 = "dashboard";
          __unkeyed-2 = "NvimTree";
          __unkeyed-3 = "Outline";
          __unkeyed-4 = "alpha";
          __unkeyed-5 = "Trouble";
        };
        component_separators = {
          left = "⏽";
          right = "⏽";
        };

        section_separators = {
          left = "";
          right = "";
        };
      };

      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch"];
        lualine_c = ["filename" "diff"];
        lualine_x = [
          {
            __unkeyed-1 = "diagnostics";
            sources = ["nvim_lsp"];
          }
          "filetype"
        ];
        lualine_y = ["progress"];
        lualine_z = ["location"];
      };

      inactive_Sections = {
        lualine_a = [""];
        lualine_b = [""];
        lualine_c = ["filename"];
        lualine_x = ["filetype"];
        lualine_y = [""];
        lualine_z = [""];
      };
    };
  };
}
