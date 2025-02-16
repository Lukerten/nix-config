{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./code.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./qt.nix
    ./thunar.nix
    ./thunderbird.nix
    ./vesktop.nix
  ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme =
    if config.colorscheme.mode == "dark"
    then "prefer-dark"
    else if config.colorscheme.mode == "light"
    then "prefer-light"
    else "default";

  xdg.portal.enable = true;
  home.sessionVariables.XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";

  home.packages = with pkgs; [
    qalculate-gtk
  ];

  suits = {
    messagers.minimal.enable = true;
    productivity.notes.enable = true;
  };
  programs = {
    audioctrl.enable = true;
    spotify.enable = true;
  };
  services = {
    nextcloud-client.enable = true;
  };
}
