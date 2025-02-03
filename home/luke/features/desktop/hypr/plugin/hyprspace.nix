{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprspace = pkgs.hyprlandPlugins.hyprspace;
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprspace];
    settings = {
      bind = [
        "SUPER,s,hyprctl dispatch overview:toggle"
      ];
      "plugin:overview" = let
        rgb = color: "rgb(${lib.removePrefix "#" color})";
        primary = rgb config.colorscheme.colors.primary;
        surface = rgb config.colorscheme.colors.surface;
        on_surface = rgb config.colorscheme.colors.on_surface;
      in {
      };
    };
  };
}
