{pkgs, ...}: {
  programs.vesktop.enable = true;

  services.arrpc = {
    enable = true;
    package = pkgs.arrpc;
    systemdTarget = "hyprland-session.target";
  };
}
