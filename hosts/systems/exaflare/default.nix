{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-hidpi
    inputs.hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix

    # common configuration
    ../../global
    ../../users/luke

    # optional configuration
    ../../optional/bluetooth.nix
    ../../optional/cups.nix
    ../../optional/pipewire.nix
    ../../optional/podman.nix
    ../../optional/quietboot.nix
    ../../optional/regreet.nix
    ../../optional/steam-hardware.nix
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
    uinput.enable = true;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  programs.gamemode = {
    enable = true;
    # settings = {
    #   general = {
    #     softrealtime = "on";
    #     inhibit_screensaver = 1;
    #   };
    #   gpu = {
    #     apply_gpu_optimisations = "accept-responsibility";
    #     gpu_device = 0;
    #     amd_performance_level = "high";
    #   };
    # };
  };

  system.stateVersion = "24.05";
}
