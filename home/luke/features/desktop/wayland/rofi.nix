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
    launcher.enable = true;
    package = pkgs.rofi-wayland;
    colorscheme = {
      background = rmHash colors.surface;
      background-alt = rmHash colors.surface_variant;
      foreground = rmHash colors.on_surface;
      selected = rmHash colors.primary;
      active = rmHash colors.secondary;
      urgent = rmHash colors.error_container;
    };
  };
}
