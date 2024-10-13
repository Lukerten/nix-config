{pkgs, config, lib, ...}:{
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      window = {
        padding = {
          x = 24;
          y = 26;
        };
        dynamic_padding = false;
        dynamic_title = true;
        decorations = "None";
      };
      scrolling = {
        history = 4000;
        multiplier = 3;
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
        inherit (config.colorscheme) colors harmonized;
      in rec {
        primary = {
          foreground = "${colors.on_surface}";
          background = "${colors.surface}";
          dim_foreground = "${colors.on_surface_variant}";
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
          black = "${colors.surface}";
          red = "${harmonized.red}";
          green = "${harmonized.green}";
          yellow = "${harmonized.yellow}";
          blue = "${harmonized.blue}";
          magenta = "${harmonized.magenta}";
          cyan = "${harmonized.cyan}";
          white = "${colors.on_surface}";
        };
        bright = normal;
      };
    };
  };
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
  };
  home.sessionVariables.NIX_INSPECT_EXCLUDE = "alacritty ncurses imagemagick fzy nix-index";
  home.packages = [
    (
      pkgs.writeShellScriptBin "xterm" ''
        ${lib.getExe config.programs.alacritty.package} "$@"
      ''
    )
  ];
}
