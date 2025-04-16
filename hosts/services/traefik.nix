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
        web.address = ":80";
        websecure.address = ":443";
      };
    };

    dynamicConfigOptions = {
      http.routers = {
        acme_challenge = {
          rule = "HostRegexp(`^(.+\.){0,1}mbretsch\.de`) && PathPrefix(`/.well-known/acme-challenge`)";
          entryPoints = ["web"];
          service = "nginx";
          tls = false;
        };
      };
    };
  };
}
