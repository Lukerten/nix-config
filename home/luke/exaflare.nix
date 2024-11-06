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

  wallpaper = pkgs.wallpapers.funky-red-cyan-landscape;
  monitors = [
    {
      name = "DP-3";
      height = 1080;
      width = 1920;
      enabled = true;
      x = 0;
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
      y = 420;
      primary = true;
      workspace = "1";
    }
    {
      name = "DP-2";
      enabled = true;
      width = 1920;
      height = 1080;
      x = 3000;
      y = 420;
      primary = false;
      workspace = "3";
    }
  ];
}
