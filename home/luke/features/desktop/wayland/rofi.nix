{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
  rmHash = lib.removePrefix "#";
in {
  programs.rofi = {
    enable = true;
    colorscheme = {
      background = rmHash colors.surface;
      background-alt = rmHash colors.surface_variant;
      foreground = rmHash colors.on_surface;
      selected = rmHash colors.primary;
      active = rmHash colors.secondary;
      urgent = rmHash colors.error_container;
    };
    font = let font = config.fontProfiles.regular; in "${font.name} ${toString font.size}";
    align = "west";
    size = {
      width = 30;
      height = 100;
      margin = 10;
    };
    xoffset = 10;

    cliphist.enable = true;
    emoji.enable = true;
    pass.enable = true;
    specialisation.enable = true;
  };
}
