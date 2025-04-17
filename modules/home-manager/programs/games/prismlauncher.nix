{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.prismLauncher;
in {
  options.programs.prismLauncher = {
    enable = mkEnableOption "prismLauncher";

    package = mkOption {
      type = types.package;
      default = pkgs.prismlauncher;
      description = "The prism-launcher package to use.";
    };

    installAdditionalJDK = mkOption {
      type = types.bool;
      default = false;
      description = "Install additional JDK.";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      [cfg.package]
      ++ (
        if cfg.installAdditionalJDK
        then [pkgs.jdk8]
        else []
      );
  };
}
