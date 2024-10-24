{
  pkgs,
  config,
  lib,
  ...
}: {
  qt.platformTheme = {
    name = "gtk3";
    package = [
      pkgs.libsForQt5.qtstyleplugins
      (pkgs.qt6.qtbase.override {
        qttranslations = null;
      })
    ];
  };
}
