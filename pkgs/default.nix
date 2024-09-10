{pkgs ? import <nixpkgs> {}, ...}: rec {
  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord {};
  trekscii = pkgs.callPackage ./trekscii {};
  lyrics = pkgs.python3Packages.callPackage ./lyrics {};
  cm4all-vpn = pkgs.callPackage ./cm4all-vpn {};
  hyprbars = pkgs.callPackage ./hyprbars {};

  # Personal scripts
  xpo = pkgs.callPackage ./xpo {};
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome {};

  # My wallpaper collection
  wallpapers = import ./wallpapers {inherit pkgs;};
  allWallpapers = pkgs.linkFarmFromDrvs "wallpapers" (pkgs.lib.attrValues wallpapers);

  # And colorschemes based on it
  generateColorscheme = import ./colorschemes/generator.nix {inherit pkgs;};
  colorschemes = import ./colorschemes {inherit pkgs wallpapers generateColorscheme;};
  allColorschemes = let
    combined = pkgs.writeText "colorschemes.json" (builtins.toJSON (pkgs.lib.mapAttrs (_: drv: drv.imported) colorschemes));
  in
    pkgs.linkFarmFromDrvs "colorschemes" (pkgs.lib.attrValues colorschemes ++ [combined]);
}
