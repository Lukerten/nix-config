{
  lib,
  config,
  ...
}: let
  inherit (config.networking) hostName;
in {
  security.acme = {
    acceptTerms = true;
    defaults.email = "lucas.brendgen@gmail.com";
    defaults.group = "acme";
  };

  users.users.nginx.extraGroups = ["acme" "nginx" "traefik"];
  services.nginx = {
    enable = true;
    virtualHosts = {
      locations."/.well-known/acme-challenge" = {
        root = "/var/lib/acme/.challenges";
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 80 443];
  };
}
