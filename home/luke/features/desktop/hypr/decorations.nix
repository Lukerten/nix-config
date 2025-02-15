{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      active_opacity = 1.00;
      inactive_opacity = 1.00;
      fullscreen_opacity = 1.00;
      rounding = 4;
      blur = {
        enabled = false;
        size = 6;
        passes = 4;
        popups = true;
      };
      shadow = {
        enabled = false;
        range = 12;
        color = "0x44000000";
        color_inactive = "0x66000000";
        offset = "3 3";
        scale = 6;
      };
    };
    animations = {
      enabled = true;
      bezier = [
        "easein,0.1, 0, 0.5, 0"
        "easeout,0.5, 1, 0.9, 1"
        "easeinout,0.45, 0, 0.55, 1"
      ];
      animation = [
        "fadeIn,1,3,easeout"
        "fadeLayersIn,1,3,easeout"
        "layersIn,1,3,easeout,slide"
        "windowsIn,1,3,easeout,slide"
        "fadeLayersOut,1,3,easein"
        "fadeOut,1,3,easein"
        "layersOut,1,3,easein,slide"
        "windowsOut,1,3,easein,slide"
        "border,1,3,easeout"
        "borderangle, 1, 100, easeout , loop"
        "fadeDim,1,3,easeinout"
        "fadeShadow,1,3,easeinout"
        "fadeSwitch,1,3,easeinout"
        "windowsMove,1,3,easeout"
        "workspaces,1,2.6,easeout,slide"
      ];
    };
  };
}
