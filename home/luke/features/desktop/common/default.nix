{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./thunar.nix
    ./thunderbird.nix
  ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme =
    if config.colorscheme.mode == "dark"
    then "prefer-dark"
    else if config.colorscheme.mode == "light"
    then "prefer-light"
    else "default";

  xdg.portal.enable = true;

  programs = {
    discord.enable = true;
    spotify.enable = true;
    obsidian.enable = true;
    obs-studio.enable = true;
    audioctrl.enable = true;
    audacity.enable = true;
    code.enable = true;
    blender.enable = true;
    deluge.enable = true;
    filezilla.enable = true;
    gimp.enable = true;
    office.enable = true;
    postman.enable = true;
  };

  programs.messager = {
    whatsapp.enable = true;
    signal.enable = true;
    slack.enable = true;
    element.enable = true;
    teamspeak.enable = true;
    webex.enable = true;
  };

  services = {
    nextcloud-client = {
      enable = true;
    };
  };
  qt.enable = true;
}
