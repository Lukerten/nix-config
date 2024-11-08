{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0cc9dce2-6348-4e18-9f75-9f92dcbcee76";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EC06-1127";
    fsType = "vfat";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/aaee0982-a4a8-48b2-8527-eb2ed20868be";}];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
