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
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_3.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_4.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_5.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_6.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_8.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_10.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_13.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_14.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_15.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_16.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_17.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_18.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_19.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_20.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_21.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_22.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_23.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_24.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_25.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_26.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_28.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_29.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_30.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_31.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_32.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_34.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_35.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_36.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_38.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_39.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_40.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_41.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_42.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_43.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_44.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_45.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_46.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_47.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_48.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_49.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_50.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_51.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_52.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_53.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_54.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_55.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_56.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_57.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_58.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_59.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_60.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_61.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_62.txt"
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_63.txt"
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
        rule = " Host(`adguard.local`) || Host(`ag.local`)";
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
