{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.neofetch;
  neofetch = pkgs.neofetch;
in {
  options.programs.neofetch = {
    enable = mkEnableOption "neofetch";

    package = mkOption {
      type = types.package;
      default = neofetch;
      description = ''
        The neofetch package.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;
    xdg.configFile."neofetch/pngs/nixos.png".source = ./nixos.png;
  };
}
