{
  outputs,
  lib,
  config,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
  filterNames = ["annihilation" "exaflare" "inception"];
  filterHostnames = builtins.filter (host: builtins.elem host filterNames) hostnames;
in {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      net = {
        host = lib.concatStringsSep " " (lib.flatten (
          map (host: [
            host
          ])
          filterHostnames
        ));
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
      "hye-fherfurt" = {
        hostname = "hye.ai.fh-erfurt.de";
        user = "student";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen_fhe";
        forwardAgent = false;
      };
      "sanctity" = {
        hostname = "23.88.53.225";
        user = "luke";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen";
        forwardAgent = false;
      };
    };
    extraConfig = ''
      IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa_Lucas_Brendgen
    '';
  };
  # Compatibility with programs that don't respect SSH configurations (e.g. jujutsu's libssh2)
  systemd.user.tmpfiles.rules = [
    "L ${config.home.homeDirectory}/.ssh/known_hosts - - - - ${config.programs.ssh.userKnownHostsFile}"
  ];
}
