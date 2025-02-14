{
  config,
  lib,
  ...
}: let
  cfg = config.programs.rofi;
  rmHash = lib.removePrefix "#";
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  imports = [
    ./cliphist.nix
    ./specialisation.nix
  ];

  options.programs.rofi = {
    size = {
      width = lib.mkOption {
        type = lib.types.int;
        default = 80;
        description = "Width for rofi in percentage";
      };

      height = lib.mkOption {
        type = lib.types.int;
        default = 80;
        description = "Height for rofi in percentage";
      };
      margin = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Margin for rofi";
      };
    };

    align = lib.mkOption {
      type = lib.types.enum ["north" "east" "south" "west"];
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
        default = "#FF00FF";
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
    programs.rofi = {
      extraConfig = {
        modi = "drun,window,ssh";
        show-icons = true;
        scroll-method = 1;
        display-drun = " ";
        display-window = " ";
        display-ssh = " ";
        drun-display-format = "{name}";
      };
      theme = {
        "*" = {
          background = mkLiteral "#${rmHash cfg.colorscheme.background}FF";
          background-alt = mkLiteral "#${rmHash cfg.colorscheme.background-alt}FF";
          foreground = mkLiteral "#${rmHash cfg.colorscheme.foreground}FF";
          selected = mkLiteral "#${rmHash cfg.colorscheme.selected}FF";
          active = mkLiteral "#${rmHash cfg.colorscheme.active}FF";
          urgent = mkLiteral "#${rmHash cfg.colorscheme.urgent}FF";
          border-color = mkLiteral "#${rmHash cfg.border.color}FF";
          border-radius = mkLiteral "${toString cfg.border.radius}px";
        };

        "window" = {
          transparency = "real";
          location = mkLiteral "${toString config.programs.rofi.align}";
          anchor = mkLiteral "${toString config.programs.rofi.align}";
          fullscreen = false;
          # Calc size to remove offset from both sides!
          width = mkLiteral "calc(${toString config.programs.rofi.size.width}% - ${toString (2 * config.programs.rofi.size.margin)}px)";
          height = mkLiteral "calc(${toString config.programs.rofi.size.height}% - ${toString (2 * config.programs.rofi.size.margin)}px)";
          enabled = true;
          xoffset = mkLiteral "0px";
          yoffset = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "2px solid";
          "border-radius" = mkLiteral "${toString config.programs.rofi.border.radius}px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "@background";
          cursor = mkLiteral "default";
        };

        "mainbox" = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "20px";
          border = mkLiteral "0px solid";
          "border-radius" = mkLiteral "0px 0px 0px 0px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "transparent";
          children = mkLiteral ''[ "inputbar", "listview" ]'';
        };

        "inputbar" = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "15px";
          border = mkLiteral "0px solid";
          "border-radius" = mkLiteral "12px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "@background-alt";
          "text-color" = mkLiteral "@foreground";
          children = mkLiteral ''[ "prompt", "entry" ]'';
        };

        "prompt" = {
          enabled = true;
          "background-color" = mkLiteral "inherit";
          "text-color" = mkLiteral "inherit";
        };

        "textbox-prompt-colon" = {
          enabled = true;
          expand = false;
          str = "";
          "background-color" = mkLiteral "inherit";
          "text-color" = mkLiteral "inherit";
        };

        "entry" = {
          enabled = true;
          "background-color" = mkLiteral "inherit";
          "text-color" = mkLiteral "inherit";
          cursor = mkLiteral "text";
          placeholder = " Search...";
          "placeholder-color" = mkLiteral "inherit";
        };

        "listview" = {
          enabled = true;
          columns = 1;
          cycle = true;
          dynamic = true;
          scrollbar = false;
          layout = mkLiteral "vertical";
          reverse = false;
          "fixed-height" = true;
          "fixed-columns" = true;
          spacing = mkLiteral "5px";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          "border-radius" = mkLiteral "0px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "transparent";
          "text-color" = mkLiteral "@foreground";
          cursor = mkLiteral "default";
        };

        "scrollbar" = {
          "handle-width" = mkLiteral "5px";
          "handle-color" = mkLiteral "@selected";
          "border-radius" = mkLiteral "0px";
          "background-color" = mkLiteral "@background-alt";
        };

        "element" = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "5px";
          border = mkLiteral "0px solid";
          "border-radius" = mkLiteral "12px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "transparent";
          "text-color" = mkLiteral "@foreground";
          cursor = mkLiteral "pointer";
        };

        "element normal.normal" = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
        };

        "element selected.normal" = {
          "background-color" = mkLiteral "@selected";
          "text-color" = mkLiteral "@background";
        };

        "element-icon" = {
          "background-color" = mkLiteral "transparent";
          "text-color" = mkLiteral "inherit";
          size = mkLiteral "32px";
          cursor = mkLiteral "inherit";
        };

        "element-text" = {
          "background-color" = mkLiteral "transparent";
          "text-color" = mkLiteral "inherit";
          highlight = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          "vertical-align" = mkLiteral "0.5";
          "horizontal-align" = mkLiteral "0.0";
        };

        "error-message" = {
          padding = mkLiteral "15px";
          border = mkLiteral "2px solid";
          "border-radius" = mkLiteral "12px";
          "border-color" = mkLiteral "@selected";
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
        };

        "textbox" = {
          "background-color" = mkLiteral "@background";
          "text-color" = mkLiteral "@foreground";
          "vertical-align" = mkLiteral "0.5";
          "horizontal-align" = mkLiteral "0.0";
          highlight = mkLiteral "none";
        };
      };
    };
  };
}
