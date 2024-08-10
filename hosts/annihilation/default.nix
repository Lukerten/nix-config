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
    ../common/optional/ckb-next.nix
    ../common/optional/cups.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/regreet.nix
    ../common/optional/steam.nix
    ../common/optional/thunar.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireshark.nix
    ../common/optional/x11-no-suspend.nix
    ../common/optional/cm4all-vpn.nix
  ];

  networking = {
    hostName = "annihilation";
    networkmanager.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    binfmt.emulatedSystems = ["aarch64-linux" "i686-linux"];
  };

  # Intel Config
  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  services.hardware.openrgb.enable = true;
  programs = {
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  system.stateVersion = "23.11";
}
