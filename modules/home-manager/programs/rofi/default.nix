{ config, pkgs, lib, ... }:
let
  cfg = config.programs.rofi;
in {
  options.programs.rofi = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = ''
        background:     #000000FF;
        background-alt: #444444FF;
        foreground:     #FFFFFFFF;
        selected:       #00FF00FF;
        active:         #00FF00FF;
        urgent:         #FF0000FF;
      '';
      description = "The colors to use in rofi.";
    };
  };

  imports = [
    ./launcher
    ./clipper
    ./specialization
  ];

  config = lib.mkIf cfg.enable {
    xdg.configFile."rofi/shared/colors.rasi".text = ''
      * {
        ${cfg.colorscheme}
      }
    '';
  }; 
}

