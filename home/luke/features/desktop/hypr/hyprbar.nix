
{
  config,
  pkgs,
  lib,
  outputs,
  ...
}: let
  rgb = color: "rgb(${lib.removePrefix "#" color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";

  hyprbars =
    (pkgs.hyprlandPlugins.hyprbars.override {
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
        bar_color = rgba config.colorscheme.colors.surface "ff";
        "col.text" = rgb config.colorscheme.colors.on_surface;
        bar_text_font = config.fontProfiles.regular.name;
        bar_text_size = config.fontProfiles.regular.size;
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
          "${rgb config.colorscheme.harmonized.red},12,,${closeAction}"
          "${rgb config.colorscheme.harmonized.yellow},12,,${minimizeAction}"
          "${rgb config.colorscheme.harmonized.green},12,,${maximizeAction}"
        ];
      };

      windowrulev2 = [
        "plugin:hyprbars:bar_color ${rgba config.colorscheme.colors.primary "ff"}, focus:1"
        "plugin:hyprbars:title_color ${rgb config.colorscheme.colors.surface}, focus:1"
      ];
    };
  };
}
