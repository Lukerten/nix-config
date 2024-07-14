{ lib, config, pkgs, ... }:
let cfg = config.programs.filemanager;
in {
  options.programs.filemanager = {
    enable = lib.mkEnableOption "File manager";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.xfce.thunar;
      description = "The file manager to use.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
