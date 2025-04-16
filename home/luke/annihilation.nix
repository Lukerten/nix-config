{pkgs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/nvim
    ./features/desktop/hypr
  ];
  wallpaper = pkgs.inputs.themes.wallpapers.pixel-vaporwave;

  system.type = "laptop";

  services = {
    batsignal.enable = true;
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };

  monitors = [
    {
      name = "eDP-1";
      width = 2520;
      height = 1680;
      enabled = true;
      x = 0;
      primary = true;
      workspace = "1";
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 2520;
      workspace = "2";
    }
  ];
}
