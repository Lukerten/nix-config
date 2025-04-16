{
  services.traefik.dynamicConfigOptions.http = {
    routers = {
      outline = {
        rule = "Host(`wiki.lukerten.de`)";
        entryPoints = ["web"];
        service = "outline";
        tls = false;
      };
      dex = {
        rule = "Host(`dex.lukerten.de`)";
        entryPoints = ["web"];
        service = "dex";
      };
    };

    services.outline.loadBalancer.servers = [
      {url = "http://127.0.0.1:3000";}
    ];
    services.dex.loadBalancer.servers = [
      {url = "http://127.0.0.1:5556";}
    ];
  };
}
