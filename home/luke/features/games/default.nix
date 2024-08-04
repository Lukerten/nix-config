{pkgs, ...}: {
  imports = [./lutris.nix ./steam.nix ./prism.nix];
  home.packages = with pkgs; [gamescope];
}
