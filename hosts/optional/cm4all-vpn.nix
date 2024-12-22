{
  pkgs,
  lib,
  ...
}: {
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware.yubikey.enable = true;
  services.pcscd.enable = lib.mkForce true;
  programs.cm4all-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    debianutils
    opensc
    socat
    (openvpn.override {
      pkcs11Support = true;
      pkcs11helper = pkgs.pkcs11helper;
    })
  ];
}
