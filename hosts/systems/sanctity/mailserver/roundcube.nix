{pkgs, ...}: {
  services.roundcube = rec {
    enable = true;
    package = pkgs.roundcube.withPlugins (p: [p.carddav]);
    hostName = "mail.lukerten.de";
    extraConfig = ''
      $config['smtp_host'] = "tls://${hostName}:587";
      $config['smtp_user'] = "%u";
      $config['smtp_pass'] = "%p";
      $config['plugins'] = [ "carddav" ];
    '';
  };
}
