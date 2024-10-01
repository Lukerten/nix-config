{
  pkgs,
  ...
}: {
  imports = [./global ./features/desktop/hypr];

  wallpaper = pkgs.wallpapers.vaporwave-mountain;

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
