{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hardware.yubikey;
in {
  options.hardware.yubikey = {
    enable = lib.mkEnableOption "Enable the cm4all-vpn utils";
    default = false;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      debianutils
      opensc
      socat
      yubico-piv-tool
      yubikey-manager
      yubikey-agent
      (openvpn.override {
        pkcs11Support = true;
        pkcs11helper = pkgs.pkcs11helper;
      })
    ];
  };
}
