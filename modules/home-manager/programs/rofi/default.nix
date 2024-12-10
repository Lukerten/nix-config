{
  config,
  lib,
  ...
}: let
  cfg = config.programs.rofi;
in {
  imports = [
    ./launcher.nix
  ];

  options.programs.rofi = {
    fontProfile = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Fira Sans";
        description = "Font for rofi";
      };

      size = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Font size for rofi";
      };
    };

    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = config.wallpaper;
      description = "Wallpaper for rofi";
    };

    align = lib.mkOption {
      type = lib.types.enum [ "north" "east" "south" "west" ];
      default = "south";
      description = "Align for rofi";
    };

    border = {
      radius = lib.mkOption {
        type = lib.types.int;
        default = 15;
        description = "Border radius for rofi";
      };

      color = lib.mkOption {
        type = lib.types.str;
        default = cfg.colorscheme.active;
        description = "Border color for rofi";
      };
    };

    colorscheme = {
      background = lib.mkOption {
        type = lib.types.str;
        default = "#000000";
        description = "Background color for rofi";
      };

      background-alt = lib.mkOption {
        type = lib.types.str;
        default = "#444444";
        description = "Alternative background color for rofi";
      };

      foreground = lib.mkOption {
        type = lib.types.str;
        default = "#FFFFFF";
        description = "Foreground color for rofi";
      };

      selected = lib.mkOption {
        type = lib.types.str;
        default = "00FF00";
        description = "Selected color for rofi";
      };

      active = lib.mkOption {
        type = lib.types.str;
        default = "#00FF00";
        description = "Active color for rofi";
      };

      urgent = lib.mkOption {
        type = lib.types.str;
        default = "#FF0000";
        description = "Urgent color for rofi";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.rofi.configPath = "$XDG_CONFIG_HOME/rofi/fallback.rasi";
    xdg.configFile = {
      "rofi/config.rasi".source = lib.mkForce ./default.rasi;
      "rofi/shared/theme.rasi".text = let
        rmHash = lib.removePrefix "#";
        r = toString cfg.border.radius;
        border-align = if cfg.align == "center" then "${r}px" else border-align-dir;
        border-align-dir = ''${border-align-single "west" "south"} ${border-align-single "south" "east"}  ${border-align-single "east" "north"} ${border-align-single "north" "west"}'';
        border-align-single = dir1: dir2: if cfg.align == dir1 || cfg.align == dir2 then "${r}px" else "0px";
      in # rasi
        ''
          * {
            font:               "${cfg.fontProfile.name} ${toString cfg.fontProfile.size}";
            wallpaper-width:    url("${cfg.wallpaper}", width);
            wallpaper-height:   url("${cfg.wallpaper}", height);
            background:         #${rmHash cfg.colorscheme.background}FF;
            background-alt:     #${rmHash cfg.colorscheme.background-alt}FF;
            foreground:         #${rmHash cfg.colorscheme.foreground}FF;
            selected:           #${rmHash cfg.colorscheme.selected}FF;
            active:             #${rmHash cfg.colorscheme.active}FF;
            urgent:             #${rmHash cfg.colorscheme.urgent}FF;
            border-color:       #${rmHash cfg.border.color}FF;
            border-radius:      ${border-align};

            /** Color Name Aliases **/
            handle-colour:               var(selected);
            background-colour:           var(background);
            border-colour:               var(active);
            foreground-colour:           var(foreground);
            alternate-background:        var(background-alt);
            normal-background:           var(background);
            normal-foreground:           var(foreground);
            urgent-background:           var(urgent);
            urgent-foreground:           var(background);
            active-background:           var(active);
            active-foreground:           var(background);
            selected-normal-background:  var(selected);
            selected-normal-foreground:  var(background);
            selected-urgent-background:  var(active);
            selected-urgent-foreground:  var(background);
            selected-active-background:  var(urgent);
            selected-active-foreground:  var(background);
            alternate-normal-background: var(background);
            alternate-normal-foreground: var(foreground);
            alternate-urgent-background: var(urgent);
            alternate-urgent-foreground: var(background);
            alternate-active-background: var(active);
            alternate-active-foreground: var(background);
          }

          window {
              transparency:                "real";
              location:                    ${cfg.align};
              anchor:                      ${cfg.align};
              fullscreen:                  false;
              width:                       1200px;
              x-offset:                    0px;
              y-offset:                    0px;
              enabled:                     true;
              cursor:                      "default";
              border-radius:               @border-radius;
              background-color:            @background;
          }

          mainbox {
              enabled:                     true;
              spacing:                     0px;
              margin:                      0px;
              padding:                     0px;
              border:                      0px solid;
              border-radius:               @border-radius;
              border-color:                @border-color;
              background-color:            transparent;
          }
        '';
    };
  };
}
