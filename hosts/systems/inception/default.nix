{
  imports = [
    ../hardware-configuration.nix
    ../../global
    ../../users/luke
  ];

  network = {
    hostName = "inception";
    useDHCP = true;
    dhcpcd.IPv6rs = true;
    interface.ens3 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "24.05"
}
