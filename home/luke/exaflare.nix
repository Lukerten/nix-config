{pkgs, ...}: {
  imports = [
    ./global
    ./features/desktop/hypr
    ./features/games
  ];

  # -----
  # |   | |------| |------|
  # |D1 | |  D2  | |  D3  |
  # |   | |------| |------|
  # -----    

  wallpaper = pkgs.wallpapers.aestetic-deer;
  monitors = [
    {
      name = "DP-2";
      width = 1080;
      height = 1920;
      enabled = true;
      x = 0;
      y = -420;
      primary = false;
      workspace = "2";
      orientation = 1;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 1080;
      primary = true;
      workspace = "1";
    }
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 3000;
      primary = false;
      workspace = "3";
    }
  ];
}
