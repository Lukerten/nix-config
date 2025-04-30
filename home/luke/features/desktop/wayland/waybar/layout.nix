{
  programs.waybar.settings.primary = {
    modules-left = [
      "custom/menu"
      "hyprland/language"
      "custom/currentplayer"
      "hyprland/workspaces"
      "custom/player"
      "custom/empty"
    ];

    modules-right = [
      "tray"
      "wlr/taskbar"
      "pulseaudio"
      "battery"
      "idle_inhibitor"
      "bluetooth"
      "network"
      "clock"
    ];
  };
}
