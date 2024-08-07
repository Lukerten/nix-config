{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./global ./features/desktop/hypr ./features/pass ./features/games];

  wallpaper = pkgs.wallpapers.anime-death;
  colorscheme.type = "rainbow";

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
  ];
}
