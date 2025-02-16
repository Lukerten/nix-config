{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {

      window = {
        padding = {
          x = 20;
          y = 20;
        };
        dynamic_padding = false;
        dynamic_title = true;
        decorations = "None";
      };
      scrolling = {
        history = 4000;
        multiplier = 3;
      };
      keyboard = {
        bindings = [
          {
            key = "N";
            mods = "Control";
            action = "CreateNewWindow";
          }
        ];
      };

      font = {
        normal = {
          family = config.fontProfiles.monospace.name;
          style = "Medium";
        };
        italic = {
          family = config.fontProfiles.monospace.name;
          style = "Italic";
        };
        bold = {
          family = config.fontProfiles.monospace.name;
          style = "Bold";
        };
        bold_italic = {
          family = config.fontProfiles.monospace.name;
          style = "Bold Italic";
        };
        size = 12;
        builtin_box_drawing = false;
      };
      bell = {
        animation = "Linear";
        duration = 500;
      };
      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };
      colors = let
        inherit (config.colorscheme) colors;
      in rec {
        primary = {
          foreground = "${colors.on_surface}";
          background = "${colors.surface}";
          dim_foreground = "${colors.outline}";
          bright_foreground = "${colors.on_surface_variant}";
        };
        search = {
          matches = {
            foreground = "${colors.surface}";
            background = "${colors.tertiary}";
          };
          focused_match = {
            foreground = "${colors.surface}";
            background = "${colors.primary}";
          };
        };
        hints = {
          start = {
            foreground = "${colors.surface}";
            background = "${colors.tertiary}";
          };
          end = {
            foreground = "${colors.surface}";
            background = "${colors.tertiary}";
          };
        };
        line_indicator = {
          foreground = "${colors.surface}";
          background = "${colors.primary}";
        };
        footer_bar = {
          foreground = "${colors.on_surface}";
          background = "${colors.surface}";
        };
        normal = {
          black = colors.surface_dim;
          white = colors.on_surface;
          red = colors.error;
          green = colors.primary;
          yellow = colors.inverse_primary;
          blue = colors.secondary;
          magenta = colors.tertiary_container;
          cyan = colors.tertiary;
        };
        bright =
          normal
          // {
            black = config.colorscheme.colors.on_surface_variant;
          };
      };
    };
  };

  # add terminal scheme handler
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
  };

  # add xterm wrapper
  home = {
    packages = [
      (
        pkgs.writeShellScriptBin "xterm" ''
          ${lib.getExe config.programs.alacritty.package} "$@"
        ''
      )
    ];
  };
}
