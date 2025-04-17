{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.tmux.pmux;
in {
  options.programs.tmux.pmux = {
    enable = mkEnableOption "pmux";

    package = mkOption {
      type = types.package;
      default = pkgs.pmux;
      description = "The pmux package";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [cfg.package];
    programs.zoxide.enable = mkDefault true;
  };
}
