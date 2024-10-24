{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.thunar;
in {
  options.programs.thunar = {
    enable = lib.mkEnableOption "Thunar, the Xfce file manager";
    plugins = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.package;
      description = "List of thunar plugins to install.";
      example = lib.literalExpression "with pkgs.xfce; [ thunar-archive-plugin thunar-volman ]";
    };
    package = lib.mkOption {
      default = pkgs.xfce.thunar;
      type = lib.types.package;
      description = "The thunar package to use.";
    };
  };
  config = lib.mkIf cfg.enable (
    let
      package = cfg.package.override {thunarPlugins = cfg.plugins;};
    in {
      home.packages = [package];
    }
  );
}
