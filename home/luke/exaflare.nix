{
  pkgs,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/hypr
  ];

  # ------ |--------| ------
  # | D1 | |   D2   | | D3 |
  # ------ |--------| ------

  archetypes = {
    gaming.enable = true;
  };
  programs.XIVLauncher.enable = false;

  wallpaper = pkgs.wallpapers.blue-red-sky-clouds;
  monitors = [
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 0;
      primary = false;
      workspace = "2";
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 1920;
      primary = true;
      workspace = "1";
    }
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 3840;
      primary = false;
      workspace = "3";
    }
  ];
}
