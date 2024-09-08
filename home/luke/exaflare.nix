{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./global
    ./features/desktop/hypr
    ./features/pass
    ./features/games
    ./features/games/ffxiv.nix
  ];

  # ------ |--------| ------
  # | D1 | |   D2   | | D3 |
  # ------ |--------| ------

  wallpaper = pkgs.wallpapers.ying-yang-koi;
  colorscheme.type = "rainbow";
  monitors = [
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      position = "auto-left";
      workspace = "2";
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      primary = true;
      workspace = "1";
    }
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      position = "auto-right";
      workspace = "3";
    }
  ];
}
