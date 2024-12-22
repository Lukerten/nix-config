{
  pkgs,
  lib,
  config,
  ...
}: {
  colorscheme.source = config.wallpaper;
  specialisation = lib.mkForce (
    lib.mapAttrs (n: w: {configuration.wallpaper = w;}) {
      inherit
        (pkgs.wallpapers)
        # Add Wallpapers here
        ;
    }
  );
}
