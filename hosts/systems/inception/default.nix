{
  imports = [
    ./hardware-configuration.nix

    ../../global
    ../../users/luke

    ../../optional/systemd-boot.nix

    ./adguard
    ./jellyfin
    ./traefik
  ];

  networking = {
    hostName = "inception";
    useDHCP = true;
    dhcpcd.IPv6rs = true;
    interfaces.ens3 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
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
