{ config, pkgs, lib, ... }:
let cfg = config.programs.deluge;
in {
  options.programs.deluge = { enable = lib.mkEnableOption "deluge"; };
  config = lib.mkIf cfg.enable { home.packages = [ pkgs.deluge ]; };
}

