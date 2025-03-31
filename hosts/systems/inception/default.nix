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
  sops.secrets.brendgen-user-password-hashed = {
    sopsFile = ./secrets.yaml;
  };
  services.openssh.enable = true;
  system.stateVersion = "24.05";
}
