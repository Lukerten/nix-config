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
    ../../global
    ../../users/luke

    # optional configuration
    ../../optional/bluetooth.nix
    ../../optional/cm4all-vpn.nix
    ../../optional/cups.nix
    ../../optional/pipewire.nix
    ../../optional/quietboot.nix
    ../../optional/regreet.nix
    ../../optional/remote-hosts.nix
    ../../optional/systemd-boot.nix
    ../../optional/thunar.nix
    ../../optional/wireshark.nix
    ../../optional/x11-no-suspend.nix
  ];

  networking = {
    hostName = "annihilation";
    networkmanager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = ["aarch64-linux" "i686-linux"];
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
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
