 {
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.tmux.pmux;
in {
  options.programs.tmux.pmux = {
    enable = lib.mkEnableOption "pmux";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pmux;
      description = "The pmux package";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    programs.zoxide.enable = lib.mkDefault true;
  };
}
