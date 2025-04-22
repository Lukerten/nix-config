{
  lib,
  inputs,
  outputs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  imports = builtins.attrValues outputs.homeManagerModules;

  sops = {
    age.keyFile = "/home/luke/.config/sops/age/keys.txt";

    defaultSopsFile = ./secrets.yaml;
    defaultSymlinkPath = "/run/user/1000/secrets";
    defaultSecretsMountPoint = "/run/user/1000/secrets.d";
  };

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home = rec {
    username = lib.mkDefault "luke";
    homeDirectory = lib.mkDefault "/home/${username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables.FLAKE = "$HOME/Projects/private/config/main";
    sessionVariables.NIX_PATH = lib.concatStringsSep ":" (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
      flake-registry = "";
      allow-import-from-derivation = true;
    };
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  };
}
