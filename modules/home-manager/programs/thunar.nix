{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.thunar;
in {
  options.programs.thunar = {
    enable = mkEnableOption "Thunar, the Xfce file manager";
    plugins = mkOption {
      default = [];
      type = types.listOf lib.types.package;
      description = "List of thunar plugins to install.";
      example = literalExpression "with pkgs.xfce; [ thunar-archive-plugin thunar-volman ]";
    };
    package = mkOption {
      default = pkgs.xfce.thunar;
      type = types.package;
      description = "The thunar package to use.";
    };
  };
  config = mkIf cfg.enable (
    let
      package = cfg.package.override {thunarPlugins = cfg.plugins;};
    in {
      home.packages = [package];
    }
  );
}
