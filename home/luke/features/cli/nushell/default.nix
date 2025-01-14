{
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    inherit (config.home) shellAliases;
    envFile.source = ./env.nu;
    extraConfig = builtins.readFile ./config.nu;
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  xdg.configFile = {
    "carapace/bridges.yaml".text = let
      toYAML = pkgs.lib.generators.toYAML {};
    in
      toYAML {
        nh = "fish";
        hyprctl = "fish";
        pass = "fish";
        nix = "fish";
        man = "fish";
        juju = "bash";
      };
  };
}
