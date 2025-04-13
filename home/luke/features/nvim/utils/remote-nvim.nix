{pkgs, ...}: {
  programs.nixvim.plugins.remote-nvim = {
    enable = true;
    settings.devpod.binary = "${pkgs.devpod}/bin/devpod";
  };
}
