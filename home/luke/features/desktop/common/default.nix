{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./code.nix
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
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

  programs = {
    audioctrl.enable = true;

    obsidian.enable = true;
    obs-studio.enable = true;
    postman.enable = true;
    spotify.enable = true;

    # Productivity
    # TODO: Create a suite for productivity
    blender.enable = true;
    gimp.enable = true;
    krita.enable = true;
    audacity.enable = true;
    office.enable = true;

    # Game Engines
    # TODO: Create a suite for game engines
    unity.enable = true;

    # Messagers
    # TODO: Create a suite for messagers
    whatsapp.enable = true;
    signal.enable = true;
    slack.enable = true;
    element.enable = true;
    teamspeak.enable = true;
    webex.enable = true;
    vesktop.enable = true;


  };
  services = {
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
  qt.enable = true;
}
