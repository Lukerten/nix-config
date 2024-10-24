{
  config,
  pkgs,
  lib,
  outputs,
  ...
}: let
  hyprgrass = pkgs.hyprlandPlugins.hyprgrass.override {
      hyprland = config.wayland.windowManager.hyprland.package;
  };
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprgrass];
    settings = {
      "plugin:touch_gestures" = {
        sensitivity = 4.0;
        workspace_swipe_fingers = 3;
        workspace_swipe_edge = "d";
        long_press_delay = 400;
        edge_margin = 10;
        experimental = {
          send_cancel = 0;
        };
        hyprgrass-bind = [
          ", edge:r:l, workspace, -1"
          ", edge:r:r, workspace, +1"
          ", swipe:4:d, killactive"
          ", longpress:2, movewindow"
          ", longpress:3, resizewindow"
        ];
      };
    };
  };
}
