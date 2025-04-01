{
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
