{
  services.traefik.dynamicConfigOptions = {
    http.routers = {
      roundcube = {
        rule = "Host(`mail.lukerten.de`)";
        entryPoints = ["websecure"];
        service = "roundcube";
        tls = {
          certResolver = "myresolver";
        };
      };
    };

    http.services = {
      roundcube = {
        loadBalancer.servers = [
        ];
      };
    };
  };
}
