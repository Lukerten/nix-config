{ config,pkgs,... }:
{
  programs.nushell = {
    enable = true;
    inherit (config.home) shellAliases;
    envFile.source = ./nushell/env.nu;
    extraConfig = # nushell
    ''
      ${builtins.readFile ./nushell/config.nu}
      source ${config.home.homeDirectory}/.config/nushell/conda-activate.nu
    '';
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  xdg.configFile = {
    "nushell/conda-activate.nu".source = ./nushell/conda-activate.nu;
    "carapace/bridges.yaml".text = let
      toYAML = pkgs.lib.generators.toYAML {};
    in toYAML {
      nh = "bash";
      hyprctl = "bash";
      pass = "bash";
      nix = "bash";
      man = "bash";
    };
  };
}
