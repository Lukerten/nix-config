{
  config,
  pkgs,
  lib,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";

  hyprbars =
    (pkgs.hyprlandPluginshyprbars.override {
      hyprland = config.wayland.windowManager.hyprland.package;
    })
    .overrideAttrs
    (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
        '';
    });
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprbars];
    settings = {
      "plugin:hyprbars" = {
        bar_height = 25;
        bar_color = rgb config.colorscheme.colors.surface;
        "col.text" = rgb config.colorscheme.colors.primary;
        bar_text_font = config.fontProfiles.regular.name;
        bar_text_size = config.fontProfiles.regular.size;
        bar_buttons_alignment = "left";
        bar_part_of_window = true;
        bar_precedence_over_border = true;
        hyprbars-button = let
          closeAction = "hyprctl dispatch killactive";
          isOnSpecial = ''hyprctl activewindow -j | jq -re 'select(.workspace.name == "special")' >/dev/null'';
          moveToSpecial = "hyprctl dispatch movetoworkspacesilent special";
          moveToActive = "hyprctl dispatch movetoworkspacesilent name:$(hyprctl -j activeworkspace | jq -re '.name')";
          minimizeAction = "${isOnSpecial} && ${moveToActive} || ${moveToSpecial}";
          maximizeAction = "hyprctl dispatch fullscreen 1";
        in [
          # Red close button
          "${rgb config.colorscheme.colors.red},12,,${closeAction}"
          # Yellow "minimize" (send to special workspace) button
          "${rgb config.colorscheme.colors.yellow},12,,${minimizeAction}"
          # Green "maximize" (fullscreen) button
          "${rgb config.colorscheme.colors.green},12,,${maximizeAction}"
        ];
      };
    };
  };
}
