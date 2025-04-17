{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.teamspeak;
in {
  options.programs.teamspeak = {
    enable = mkEnableOption "Enable teamspeak";
    package = mkOption {
      type = types.package;
      default = pkgs.teamspeak_client;
      description = "teamspeak package";
    };
  };
  config = mkIf cfg.enable {home.packages = [cfg.package];};
}
