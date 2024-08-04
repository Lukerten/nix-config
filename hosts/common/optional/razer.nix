{pkgs, ...}: {
  hardware.openrazer = {
    enable = true;
    users = ["luke" "root"];
    devicesOffOnScreensaver = false;
  };
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.openrazer
    linuxKernel.packages.linux_zen.system76
    openrazer-daemon
    polychromatic
  ];
}
