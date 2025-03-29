{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../global
    ../../users/luke

    ../../optional/systemd-boot.nix

    ./adguardhome
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

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
