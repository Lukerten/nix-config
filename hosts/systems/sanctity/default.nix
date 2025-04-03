{
  imports = [
    ./hardware-configuration.nix

    ../../global
    ../../users/luke
    ../../services/traefik.nix
    ../../services/acme.nix
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

  sops.secrets = {
    lucas-brendgen-mail-password-hashed.sopsFile = ./secrets.yaml;
    grafana-mail-password-hashed.sopsFile = ./secrets.yaml;
  };

  system.stateVersion = "24.05";
}
