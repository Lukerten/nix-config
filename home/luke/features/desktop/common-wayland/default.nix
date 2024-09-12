{pkgs,lib,config, ...}: {
  imports = [
    ./gammastep.nix
    ./imv.nix
    ./kitty.nix
    ./mako.nix
    ./qutebrowser.nix
    ./rofi.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./zathura.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [wf-recorder wl-clipboard];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
    WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = 1;
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.portal.extraPortals = let
    hyprlandMode = !config.wayland.windowManager.hyprland.enable;
  in lib.mkIf hyprlandMode [
    pkgs.xdg-desktop-portal-wlr
  ];
}
