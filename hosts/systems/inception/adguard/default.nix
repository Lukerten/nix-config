{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [53];
    allowedUDPPorts = [53];
  };

  # Adguard will filter traffic so only non commercial traffic is allowed
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    host = "127.0.0.1";
    port = 3000;
    settings = {
      http.address = "127.0.0.1:3000";
      dns = {
        upstream_dns = [
          "9.9.9.9#dns.quad9.net"
          "149.112.112.112#dns.quad.net"
          "8.8.8.8"
        ];
        bind_hosts = ["0.0.0.0"];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;
        safe_search.enabled = true;
        rewrites = [
          {
            "domain" = "local";
            "answer" = "192.168.2.222";
          }
          {
            "domain" = "*.local";
            "answer" = "192.168.2.222";
          }
          {
            "domain" = "speedport.ip";
            "answer" = "192.168.178.1";
          }
        ];
      };
      filters =
        map (url: {
          enabled = true;
          url = url;
        }) [
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
          "https://big.oisd.nl/"
        ];
      statistics = {
        enabled = true;
        interval = "72h";
      };
      querylog = {
        enabled = true;
        interval = "24h";
      };
      log = {
        max_size = 10;
        max_age = 30;
        compress = true;
      };
    };
  };

  services.traefik.dynamicConfigOptions = {
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
}
