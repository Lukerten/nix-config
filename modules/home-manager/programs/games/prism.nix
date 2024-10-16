{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.prism-launcher;
in {
  options.programs.prism-launcher = {
    enable = lib.mkEnableOption "prism-launcher";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.prismlauncher;
      description = "The prism-launcher package to use.";
    };

    installAdditionalJDK = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install additional JDK.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      [cfg.package]
      ++ (
        if cfg.installAdditionalJDK
        then [pkgs.jdk8]
        else []
      );
  };
}
