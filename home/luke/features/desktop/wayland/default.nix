{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./gammastep.nix
    ./imv.nix
    ./mako.nix
    ./mpv.nix
    ./rofi.nix
    ./qutebrowser.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./zathura.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [wf-recorder wl-clipboard];
  services.cliphist.enable = true;

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
    WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = 1;
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
