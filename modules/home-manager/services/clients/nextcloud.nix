{ config, pkgs, lib, ... }:
let cfg = config.service.nextcloud-client;
in {
  options.service.nextcloud-client = {
    enable = lib.mkEnableOption "nextcloud-client";

    package = lib.mkOption {
      type = with pkgs; lib.types.package;
      default = pkgs.nextcloud-client;
      description = "The package to use for the Nextcloud client.";
    };
  };
  config = lib.mkIf cfg.enable { home.packages = [ cfg.package ]; };
}
