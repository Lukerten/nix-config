{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.hardware.yubikey;
in {
  options.hardware.yubikey = {
    enable = mkEnableOption "Enable yubikey utils";

    yubikeyManager = mkOption {
      type = types.package;
      default = pkgs.yubikey-manager;
      description = "The package to install for yubikey management";
    };

    yubikeyPiv = mkOption {
      type = types.package;
      default = pkgs.yubico-piv-tool;
      description = "The package to install for yubikey piv";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.yubikeyManager
      cfg.yubikeyPiv
    ];
  };
}
