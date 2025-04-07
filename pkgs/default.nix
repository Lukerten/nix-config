{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  trekscii = pkgs.callPackage ./trekscii {};
  lyrics = pkgs.python3Packages.callPackage ./lyrics {};
  fultimator-desktop = pkgs.callPackage ./fultimator-desktop {};

  # Git additions
  git-bare-clone = pkgs.callPackage ./git-bare-clone {};
  git-create-worktree = pkgs.callPackage ./git-create-worktree {};
  git-fixup = pkgs.callPackage ./git-fixup {};
  git-recent = pkgs.callPackage ./git-recent {};
  git-track = pkgs.callPackage ./git-track {};

  # Personal scripts
  minicava = pkgs.callPackage ./minicava {};
  pvim = pkgs.callPackage ./pvim {};
  pmux = pkgs.callPackage ./pmux {};
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome {};
  xpo = pkgs.callPackage ./xpo {};
}
