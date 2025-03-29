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
    dynamicConfigOptions = {
      http.routers = {
        adguard = {
          rule = " Host(`ag.local`)";
          entryPoints = ["web"];
          service = "adguard";
          tls = false;
        };
      };

      http.services = {
        adguard = {
          loadBalancer.servers = [
            {url = "http://127.0.0.1:3000";}
          ];
        };
      };
    };
  };
}
