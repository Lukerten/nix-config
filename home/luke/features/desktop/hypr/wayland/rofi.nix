{ config, lib, pkgs, ... }:
let
  inherit (config.colorscheme) colors;
  rmHash = lib.removePrefix "#";
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    colorscheme = ''
      background:     #${rmHash colors.surface}FF;
      background-alt: #${rmHash colors.surface_variant}FF;
      foreground:     #${rmHash colors.on_surface}FF;
      selected:       #${rmHash colors.primary_container}FF;
      active:         #${rmHash colors.primary_container}FF;
      urgent:         #${rmHash colors.error_container}FF;
    '';
    enableLauncher = true;
    enableClipper = true;
    enableSpecialisation = true;
  };

  services.cliphist.enable = true;
}
