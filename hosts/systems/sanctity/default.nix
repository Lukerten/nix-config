{
  imports = [
    ./hardware-configuration.nix

    ../../optional/systemd-boot.nix

    ../../global
    ../../users/luke
  ];

  networking = {
    hostName = "sanctity";
    useDHCP = true;
    dhcpcd.IPv6rs = true;
    interfaces.ens3 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
  };
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "24.05";
}
