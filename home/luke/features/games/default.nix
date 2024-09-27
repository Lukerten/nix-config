{pkgs, ...}: {
  imports = [./steam.nix ./prism.nix ./emulators.nix];
}
