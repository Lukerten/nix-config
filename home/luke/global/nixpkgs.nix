{
  outputs,
  lib,
  inputs,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
