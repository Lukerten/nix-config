{pkgs ? import <nixpkgs> {}, ...}: rec {
  rgbdaemon = pkgs.callPackage ./rgbdaemon {};
  shellcolord = pkgs.callPackage ./shellcolord {};
  trekscii = pkgs.callPackage ./trekscii {};
  compiz = pkgs.callPackage ./compiz {};
  cm4all-vpn = pkgs.callPackage ./cm4all-vpn {};

  # stolen from misterio77
  nix-inspect = pkgs.callPackage ./nix-inspect {};
  xpo = pkgs.callPackage ./xpo {};
  plymouth-spinner-monochrome =
    pkgs.callPackage ./plymouth-spinner-monochrome {};
  wallpapers = import ./wallpapers {inherit pkgs;};
  allWallpapers =
    pkgs.linkFarmFromDrvs "wallpapers" (pkgs.lib.attrValues wallpapers);
  generateColorscheme = import ./colorschemes/generator.nix {inherit pkgs;};
  colorschemes =
    import ./colorschemes {inherit pkgs wallpapers generateColorscheme;};
  allColorschemes = let
    combined =
      pkgs.writeText "colorschemes.json"
      (builtins.toJSON (pkgs.lib.mapAttrs (_: drv: drv.imported) colorschemes));
  in
    pkgs.linkFarmFromDrvs "colorschemes"
    (pkgs.lib.attrValues colorschemes ++ [combined]);
}
