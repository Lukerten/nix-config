{ config, pkgs, lib, ... }:
let cfg = config.programs.gimp;
in {
  options.programs.gimp = {
    enable = lib.mkEnableOption "gimp";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.gimp;
      description = "The Gimp package to use.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
