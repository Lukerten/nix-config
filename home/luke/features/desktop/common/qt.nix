{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme = {
      name = "gtk3";
      package = pkgs.qt6.qtbase.override {
        patches = [ ./qtbase-gtk3-xdp.patch ];
        qttranslations = null;
      };
    };
  };
}
