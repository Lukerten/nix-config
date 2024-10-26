{pkgs, config, ...}:{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [
        "${config.wallpaper}"
      ];
      wallpaper = [
        ",${config.wallpaper}"
      ];
    };
  };
}
