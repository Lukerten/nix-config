{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord {};
  trekscii = pkgs.callPackage ./trekscii {};
  lyrics = pkgs.python3Packages.callPackage ./lyrics {};
  fultimator-desktop = pkgs.callPackage ./fultimator-desktop {};

  # Personal scripts
  minicava = pkgs.callPackage ./minicava {};
  pvim = pkgs.callPackage ./pvim {};
  pmux = pkgs.callPackage ./pmux {};
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome {};
  xpo = pkgs.callPackage ./xpo {};
}
