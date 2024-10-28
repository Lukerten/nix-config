{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.cm4all-vpn;
in {
  options.programs.cm4all-vpn = {
    enable = lib.mkEnableOption "cm4all-vpn";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.cm4all-vpn;
      description = "The cm4all-vpn package";
    };
  };
  config = lib.mkIf cfg.enable {environment.systemPackages = [cfg.package];};
}
