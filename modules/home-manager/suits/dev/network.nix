{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf mkDefault types;
  cfg = config.suits.dev.network;
in {
  options.suits.dev.network = {
    enable = mkEnableOption "Network development";
  };

  config.programs = mkIf cfg.enable {
    filezilla.enable = mkDefault true;
  };
}
