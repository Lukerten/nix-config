{ lib, pkgs, config, ... }: {
  imports = [ ./firefox.nix ./thunderbird.nix ./font.nix ./gtk.nix ./qt.nix ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme =
    if config.colorscheme.mode == "dark" then
      "prefer-dark"
    else if config.colorscheme.mode == "light" then
      "prefer-light"
    else
      "default";

  xdg.portal.enable = true;

  programs = {
    discord.enable = true;
    spotify.enable = true;
    obsidian.enable = true;
    code.enable = true;
    audioctrl.enable = true;
    filemanager.enable = true;
    audacity.enable = true;
    blender.enable = true;
    deluge.enable = true;
    filezilla.enable = true;
    gimp.enable = true;
    messager = {
      whatsapp.enable = true;
      signal.enable = true;
      element.enable = true;
    };
    office.enable = true;
    teamspeak.enable = true;
  };

  services = {
    nextcloud-client = {
      enable = true;
      package = pkgs.stable.nextcloud-client;
    };
  };
}
