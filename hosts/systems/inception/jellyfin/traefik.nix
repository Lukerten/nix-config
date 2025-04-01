{
  services.traefik.dynamicConfigOptions = {
    http.routers = {
      jellyfin = {
        rule = "Host(`jellyfin.local`) || Host(`jf.local`)";
        entryPoints = ["web"];
        service = "jellyfin";
        tls = false;
      };
    };

    http.services = {
      jellyfin = {
        loadBalancer.servers = [
          {url = "http://127.0.0.1:8096";}
        ];
      };
    };
  };
}
