{pkgs, ...}: {
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
