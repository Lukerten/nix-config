{ pkgs, inputs, ... }: {
  imports = [
    # hardware configuration
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # host specific configuration
    ./hardware-configuration.nix

    # common configuration
    ../common/global
    ../common/users/luke

    # optional configuration
    ../common/optional/bluez.nix
    ../common/optional/ckb-next.nix
    ../common/optional/cups.nix
    ../common/optional/pipewire.nix
    ../common/optional/regreet.nix
    ../common/optional/steam.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireshark.nix
    ../common/optional/x11-no-suspend.nix
    ../common/optional/quietboot.nix
    ../common/optional/thunar.nix
    ../common/optional/usb-auto.nix
  ];

  system.stateVersion = "23.11";

  networking = {
    hostName = "exaflare";
    networkmanager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  hardware = {
    graphics.enable = true;
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
    kdeconnect.enable = true;
  };
}
