{ pkgs, ... }: {
  home.packages = with pkgs; [ neofetch imagemagick ];
  xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;
}
