{
  imports = [
    ./hardware-configuration.nix
    ./outline
    ../../global
    ../../users/luke
    ../../services/traefik.nix
    ../../services/acme.nix
  ];

  networking = {
    hostName = "sanctity";
    useDHCP = true;
    interfaces.enp1s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;
      ipv6.addresses = [
        {
          address = "2a01:4f8:1c1e:dc97::1";
          prefixLength = 64;
        }
      ];
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
