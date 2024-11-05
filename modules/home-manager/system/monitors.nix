{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.monitors;
in {
  options.monitors = mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          example = "DP-1";
        };
        primary = mkOption {
          type = types.bool;
          default = false;
        };
        width = mkOption {
          type = types.int;
          example = 1920;
        };
        height = mkOption {
          type = types.int;
          example = 1080;
        };
        refreshRate = mkOption {
          type = types.int;
          default = 60;
        };
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        workspace = mkOption {
          type = types.nullOr types.str;
          default = null;
        };
        orientation = mkOption {
          type = types.nullOr types.int;
          default = 0;
          description = ''
            0 -> normal (no transforms)
            1 -> 90 degrees
            2 -> 180 degrees
            3 -> 270 degrees
            4 -> flipped
            5 -> flipped + 90 degrees
            6 -> flipped + 180 degrees
            7 -> flipped + 270 degrees
          '';
        };
      };
    });
    default = [];
  };
  config = {
    assertions = [
      {
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
