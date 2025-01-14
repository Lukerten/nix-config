{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.pvim;
  inherit (lib) mkOption mkIf types getExe;
in {
  options.programs.pvim = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "The pvim package";
    };
    package = mkOption {
      type = types.package;
      default = pkgs.pvim;
      description = "The pvim package";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    programs.zoxide.enable = true;
  };
}
