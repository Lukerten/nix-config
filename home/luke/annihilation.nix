{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [./global ./features/desktop/hypr ./features/pass ./features/games];

  wallpaper = pkgs.wallpapers.aenami-rooflines;
  colorscheme.type = "rainbow";

  monitors = [
    {
      name = "eDP-1";
      width = 2520;
      height = 1680;
      primary = true;
      workspace = "1";
    }
  ];
}
