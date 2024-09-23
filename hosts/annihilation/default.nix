{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    # common configuration
    ../common/global
    ../common/users/luke

    # optional configuration
    ../common/optional/bluez.nix
    ../common/optional/cups.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/regreet.nix
    ../common/optional/remote-hosts.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireshark.nix
    ../common/optional/x11-no-suspend.nix
  ];

  networking = {
    hostName = "annihilation";
    networkmanager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = ["aarch64-linux" "i686-linux"];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    uinput.enable = true;
    enableAllFirmware = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    light.enable = true;
  };

  system.stateVersion = "23.11";
}
