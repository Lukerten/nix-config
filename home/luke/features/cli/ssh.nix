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
    matchBlocks = let
      home = config.home.homeDirectory;
    in {
      net = {
        host = builtins.concatStringsSep " " hostnames;
        forwardAgent = true;
      };
      "gox-lucasb" = {
        hostname = "gox-lucasb.os.intern.cm-ag";
        user = "debian";
        identityFile = "${home}/.ssh/id_Lucas.Brendgen.rsa";
        forwardAgent = true;
      };
      "smb-server" = {
        hostname = "*.smb-server";
        forwardAgent = false;
        identityFile = "${home}/.ssh/id_Lucas.Brendgen.rsa";
      };
      "t8o.de" = {
        hostname = "*.t8o.de";
        forwardAgent = false;
        identityFile = "${home}/.ssh/id_Lucas.Brendgen.rsa";
      };
      "hye-fhe" = {
        hostname = "hye.ai.fh-erfurt.de";
        user = "lucasb";
        identityFile = "${home}/.ssh/id_fsr.Lucas.Brendgen.rsa";
        forwardAgent = false;
      };
    };
  };
}
