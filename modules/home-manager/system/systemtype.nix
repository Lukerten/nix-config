{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.system;
in {
  options.system = {
    type = mkOption {
      type = types.nullOr (types.enum ["laptop" "desktop"]);
      default = null;
      example = "desktop";
      description = ''
        Type of system to use. Can be either "desktop" or "laptop".
        This is used to determine the default lock time and other
        settings.
      '';
    };
    lockTime = let
      minute = 60;
      defaultTimes = {
        null = 1 * minute;
        laptop = 5 * minute;
        desktop = 20 * minute;
      };
    in {
      type = types.int;
      default = defaultTimes.${toString cfg.type or "null"};
      example = 300;
      description = ''
        Time in seconds to wait before locking the screen.
        Defaults based on system type:
          - laptop: 5 minutes
          - desktop: 20 minutes
          - null/unspecified: 1 minute
      '';
    };
  };
}
