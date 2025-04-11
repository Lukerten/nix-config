{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme = {
      name = "gtk3";
      package = [
        pkgs.libsForQt5.qtstyleplugins
        (pkgs.qt6.qtbase.override {
          inherit (pkgs) cups;
          withGtk3 = true;
          qttranslations = null;
        })
      ];
    };
  };
}
