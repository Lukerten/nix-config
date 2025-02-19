{
  programs.waybar.settings.primary = {
    modules-left = [
      "custom/menu"
      "custom/currentplayer"
      "hyprland/workspaces"
      "custom/player"
      "custom/empty"
    ];

    modules-center = [
      "hyprland/window"
      "custom/empty"
    ];

    modules-right = [
      "tray"
      "wlr/taskbar"
      "idle_inhibitor"
      "bluetooth"
      "network"
      "battery"
      "clock"
    ];
  };
}
