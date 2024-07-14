{ outputs, lib, ... }:
let hostnames = builtins.attrNames outputs.nixosConfigurations;
in {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " hostnames;
        forwardAgent = true;
      };
    };
  };
}
