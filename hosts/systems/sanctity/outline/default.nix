{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./traefik.nix
  ];

  services.outline = {
    enable = true;
    publicUrl = "http://wiki.lukerten.de";
    forceHttps = false;
    storage.storageType = "local";
    oidcAuthentication = {
      # Parts taken from
      # http://dex.localhost/.well-known/openid-configuration
      authUrl = "http://dex.lukerten.de/auth";
      tokenUrl = "http://dex.lukerten.de/token";
      userinfoUrl = "http://dex.lukerten.de/userinfo";
      clientId = "outline";
      clientSecretFile = (builtins.elemAt config.services.dex.settings.staticClients 0).secretFile;
      scopes = ["openid" "email" "profile"];
      usernameClaim = "preferred_username";
      displayName = "Dex";
    };
  };

  services.dex = {
    enable = true;
    settings = {
      issuer = "http://dex.lukerten.de";
      storage.type = "sqlite3";
      web.http = "127.0.0.1:5556";
      enablePasswordDB = true;
      staticClients = [
        {
          id = "outline";
          name = "Outline Client";
          redirectURIs = ["http://wiki.lukerten.de/auth/oidc.callback"];
          secretFile = "${pkgs.writeText "outline-oidc-secret" "test123"}";
        }
      ];
      staticPasswords = [
        {
          email = "lucas.brendgen@gmail.com";
          hash = "$2a$12$csDt73xmWH44F23k8.RL2u8DOdowoYJspCHssOlywMHixPehb1.6u";
          username = "Luke";
          userID = "6D196B03-8A28-4D6E-B849-9298168CBA34";
        }
        {
          email = "vasilis12.manetas@gmail.com";
          hash = "$2a$12$RYkxBe2zinDEvDyiy9PA4.uBdB7/ObSZmy85iiuD22tKRd9E4Qbcq";
          username = "Vasilis";
          userID = "d0bbb5b2-f833-4e8a-a904-55b85b5d698d";
        }
        {
          email = "claralestrange007@gmail.com";
          hash = "$2a$13$/lAWcN7TdxbI5w98xAvcZODjS7PNi/xMUFGEdSvFd/9LiyIx2YXA.";
          username = "Josefine";
          userID = "9bc3b5b7-cc7c-44ac-93c2-141014c0784a";
        }
      ];
    };
  };
}
