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
        forwardAgent = false;
      };
      "hye-fherfurt" = {
        hostname = "hye.ai.fh-erfurt.de";
        user = "lucasb";
        identityFile = "${home}/.ssh/id_fsr.Lucas.Brendgen.rsa";
        forwardAgent = false;
      };
    };
  };
}
