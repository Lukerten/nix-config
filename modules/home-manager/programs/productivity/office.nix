{ config, pkgs, lib, ... }:
let cfg = config.programs.office;
in {
  options.programs.office = {
    enable = lib.mkEnableOption "office";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.onlyoffice-bin;
      description = "The Office package to use.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
