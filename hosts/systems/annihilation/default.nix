{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-hidpi
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    # common configuration
    ../../global
    ../../users/luke

    # optional configuration
    ../../optional/bluetooth.nix
    ../../optional/cups.nix
    ../../optional/podman.nix
    ../../optional/pipewire.nix
    ../../optional/podman.nix
    ../../optional/quietboot.nix
    ../../optional/regreet.nix
    ../../optional/systemd-boot.nix
    ../../optional/thunar.nix
    ../../optional/upower.nix
    ../../optional/wireshark.nix
    ../../optional/x11-no-suspend.nix
  ];

  networking = {
    hostName = "annihilation";
    networkmanager.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    uinput.enable = true;
    enableAllFirmware = true;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    light.enable = true;
  };

  services = {
    blueman.enable = true;
  };

  system.stateVersion = "24.05";
}
