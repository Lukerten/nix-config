{pkgs ? import <nixpkgs> {}, ...}: rec {
  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord {};
  trekscii = pkgs.callPackage ./trekscii {};
  lyrics = pkgs.python3Packages.callPackage ./lyrics {};
  cm4all-vpn = pkgs.callPackage ./cm4all-vpn {};

  # Personal scripts
  xpo = pkgs.callPackage ./xpo {};
  pvim = pkgs.callPackage ./pvim {};
  pmux = pkgs.callPackage ./pmux {};
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome {};
}
