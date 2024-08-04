{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.programs.youtube-tui;
  package = pkgs.youtube-tui;
in {
  options.programs.youtube-tui = {
    enable = mkEnableOption "youtube-tui";
    
    package = mkOption {
      default = package;
      type = lib.types.package;
      description = ''
        The youtube-tui package to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [cfg.package];
    };
  };
}
