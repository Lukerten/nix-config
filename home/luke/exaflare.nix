{pkgs, ...}: {
  imports = [
    ./global
    ./features/cli
    ./features/nvim
    ./features/desktop/hypr
    ./features/games
  ];

  system.type = "desktop";

  # |------| |------| |------|
  # |  D1  | |  D2  | |  D3  |
  # |------| |------| |------|

  wallpaper = pkgs.inputs.themes.wallpapers.pixel-waterfall;

  programs.fultimator-desktop.enable = true;
  programs.path-of-building.enable = true;

  monitors = [
    {
      name = "DP-2";
      enabled = true;
      width = 1920;
      height = 1080;
      x = 0;
      y = 0;
      primary = false;
      workspace = "2";
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 1920;
      y = 0;
      primary = true;
      workspace = "1";
    }
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      enabled = true;
      x = 3840;
      y = 0;
      primary = false;
      workspace = "3";
    }
  ];
}
