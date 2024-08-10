{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.cm4all-vpn;
in {
  options.programs.cm4all-vpn = {
    enable = lib.mkEnableOption "Enable the cm4all-vpn utils";
    default = false;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cm4all-vpn
      socat
      yubico-piv-tool
      yubikey-manager
      which
      debianutils
      yubikey-agent
      opensc
      (openvpn.override {
        pkcs11Support = true;
        pkcs11helper = pkgs.pkcs11helper;
      })
    ];
  };
}
