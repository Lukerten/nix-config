{
  # list of hosts we need to set up
  networking.hosts = {
    "172.30.15.93" = [
      # GoX Core
      "mocks-gox.dev.smbro.server.lan"
      "editor-gox.dev.smbro.server.lan"
      "templates-gox.dev.smbro.server.lan"
      "web-traefik-gox.dev.smbro.server.lan"
      "proxy-imgproxy-gox.dev.smbro.server.lan"
      "static-files-gox.dev.smbro.server.lan"
      "authoring-data-gox.dev.smbro.server.lan"
      "dispatcher-gox.dev.smbro.server.lan"
      "content-service-gox.dev.smbro.server.lan"

      # GoX Website
      "website-data-gox.dev.smbro.server.lan"
      "rendering-service-gox.dev.smbro.server.lan"
      "authoring-gox.dev.smbro.server.lan"
      "authoring-editor-gox.dev.smbro.server.lan"
      "traefik.localhost"

      # PSE
      "mock-service-pse.dev.smbro.server.lan"
      "mocks-pse.dev.smbro.server.lan"
      "plugin-store-service-pse.dev.smbro.server.lan"
      "presence.dev.smbro.server.lan"
      "presence-de.dev.smbro.server.lan"
      "presence-ca.dev.smbro.server.lan"
      "presence-co-uk.dev.smbro.server.lan"
      "presence-com.dev.smbro.server.lan"

      "presence-es.dev.smbro.server.lan"
      "presence-mx.dev.smbro.server.lan"
      "presence-fr.dev.smbro.server.lan"
      "presence-it.dev.smbro.server.lan"
      "data-service-pse.dev.smbro.server.lan"
      "dispatcher-ps-pse.dev.smbro.server.lan"
      "ranking-coach-pse.dev.smbro.server.lan"
      "screenshot-service-pse.dev.smbro.server.lan"

      # GoX Sitebuilder
      "authoring-editor-gox.dev.smbro.server.lan"
      "authoring-gox.dev.smbro.server.lan"
      "templates-gox.dev.smbro.server.lan"
      "editor-gox.dev.smbro.server.lan"
      "sitebuilder-com.dev.smbro.server.lan"
      "sitebuilder-ca.dev.smbro.server.lan"
      "sitebuilder-co-uk.dev.smbro.server.lan"
      "sitebuilder-fr.dev.smbro.server.lan"

      "sitebuilder-de.dev.smbro.server.lan"
      "sitebuilder-it.dev.smbro.server.lan"
      "sitebuilder-es.dev.smbro.server.lan"
      "sitebuilder-mx.dev.smbro.server.lan"
      "mobile-editor-gox.dev.smbro.server.lan"
      "mocks-gox.dev.smbro.server.lan"
      "dispatcher-gox.dev.smbro.server.lan"
      "website-data-gox.dev.smbro.server.lan"

      # GoX Wordpress
      "content-service-gox.dev.smbro.server.lan"
      "rendering-service-gox.dev.smbro.server.lan"
      "wordpress-gox.dev.smbro.server.lan"
      "website-services-gox.dev.smbro.server.lan"
      "rp-gox.dev.smbro.server.lan"
      "dispatcher-gox.dev.smbro.server.lan"
      "proxy-imgproxy-gox.dev.smbro.server.lan"
      "static-files-gox.dev.smbro.server.lan"
    ];
  };
}
