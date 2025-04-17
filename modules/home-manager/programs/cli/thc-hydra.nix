{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.thc-hydra;
in {
  options.programs.thc-hydra = {
    enable = mkEnableOption "THC Hydra password cracking tool";

    package = mkOption {
      type = types.package;
      default = pkgs.thc-hydra;
      description = "The package to use for THC Hydra.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
