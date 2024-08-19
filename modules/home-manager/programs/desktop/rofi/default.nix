{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.rofi;

  default-theme = ''
    background:     #000000FF;
    background-alt: #444444FF;
    foreground:     #FFFFFFFF;
    selected:       #00FF00FF;
    active:         #00FF00FF;
    urgent:         #FF0000FF;
  '';

in {
  options.programs.rofi = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = default-theme;
      description = "The colors to use in rofi.";
    };
  };

  imports = [./launcher ./clipper ./specialization ./window-switcher];

  config = lib.mkIf cfg.enable {
    xdg.configFile."rofi/shared/colors.rasi".text = ''
      * {
        ${cfg.colorscheme}
      }
      '';

    xdg.configFile."rofi/config.rasi".source = ./config.rasi;

    programs.rofi.configPath = ".config/rofi/generated.rasi";

  };
}
