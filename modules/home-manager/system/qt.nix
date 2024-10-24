{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.qt;
in {
  qt = lib.mkIf cfg.enable {
    platformTheme = {
      name = "gtk3";
      package = [
        pkgs.libsForQt5.qtstyleplugins
        (pkgs.qt6.qtbase.override {
          qttranslations = null;
        })
      ];
    };
  };
}
