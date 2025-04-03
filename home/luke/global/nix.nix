{
  outputs,
  lib,
  inputs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
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

  home.sessionVariables = {
    NIX_PATH = lib.concatStringsSep ":" (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };
}
