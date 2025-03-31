{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };

  services.traefik = {
    enable = true;
    staticConfigOptions = {
      global = {
        checkNewVersion = false;
        sendAnonymousUsage = false;
      };
      entryPoints = {
        web = {
          address = ":80";
        };
      };
    };
  };
}
