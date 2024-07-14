{ config, pkgs, lib, ... }:
let cfg = config.programs.filezilla;
in {
  options.programs.filezilla = {
    enable = lib.mkEnableOption "filezilla";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.filezilla;
      description = "The Filezilla package to use.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
