{pkgs, ...}: {
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.p11.enable = true;
  };

  hardware.yubikey.enable = true;

  services = {
    yubikey-agent.enable = true;
    pcscd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    debianutils
    opensc
    socat
    pkcs11-provider
    pkcs11helper
    (openvpn.override {
      pkcs11Support = true;
      useSystemd = true;
    })
  ];
}
