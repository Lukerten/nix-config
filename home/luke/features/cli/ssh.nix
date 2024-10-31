{
  outputs,
  lib,
  config,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      net = {
        host = lib.concatStringsSep " " (lib.flatten (map (host: [
            host
          ])
          hostnames));
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = ''/%d/.gnupg-sockets/S.gpg-agent'';
            host.address = ''/%d/.gnupg-sockets/S.gpg-agent.extra'';
          }
          {
            bind.address = ''/%d/.waypipe/server.sock'';
            host.address = ''/%d/.waypipe/client.sock'';
          }
        ];
        forwardX11 = true;
        forwardX11Trusted = true;
        setEnv.WAYLAND_DISPLAY = "wayland-waypipe";
        extraOptions.StreamLocalBindUnlink = "yes";
      };
      "gox-lucasb" = {
        hostname = "gox-lucasb.os.intern.cm-ag";
        user = "debian";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen_cm";
        forwardAgent = false;
      };
      "hye-fherfurt" = {
        hostname = "hye.ai.fh-erfurt.de";
        user = "lucasb";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen_fhe";
        forwardAgent = false;
      };
    };
    extraConfig = ''
      IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen
      IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen_fhe
      IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen_cm
      IdentityFile ${config.home.homeDirectory}/.ssh/id_ed25519_Lucas_Brendgen_cm
    '';
  };
  # Compatibility with programs that don't respect SSH configurations (e.g. jujutsu's libssh2)
  systemd.user.tmpfiles.rules = [
    "L ${config.home.homeDirectory}/.ssh/known_hosts - - - - ${config.programs.ssh.userKnownHostsFile}"
  ];
}
