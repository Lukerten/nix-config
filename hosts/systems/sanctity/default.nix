{
  imports = [
    ./hardware-configuration.nix

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

  boot.loader = {
    grub.enable = true;
    grub.device = "nodev";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "24.05";
}
