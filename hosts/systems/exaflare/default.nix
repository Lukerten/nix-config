{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    # common configuration
    ../../global
    ../../users/luke

    # optional configuration
    ../../optional/bluetooth.nix
    ../../optional/cups.nix
    ../../optional/pipewire.nix
    ../../optional/quietboot.nix
    ../../optional/regreet.nix
    ../../optional/systemd-boot.nix
    ../../optional/thunar.nix
    ../../optional/wireshark.nix
    ../../optional/x11-no-suspend.nix
  ];

  networking = {
    hostName = "exaflare";
    networkmanager.enable = true;
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

  programs = {
    adb.enable = true;
    dconf.enable = true;
    light.enable = true;
  };

  system.stateVersion = "24.05";
}
