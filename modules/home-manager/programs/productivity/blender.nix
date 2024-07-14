{ config, pkgs, lib, ... }:
let cfg = config.programs.blender;
in {
  options.programs.blender = {
    enable = lib.mkEnableOption "blender";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.blender;
      description = "The Blender package to use.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}

