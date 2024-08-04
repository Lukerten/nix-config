{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental;
    settings.Policy.AutoEnable = "true";
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      ControllerMode = "dual";
      FastConnectable = "true";
      Experimental = "true";
      KernelExperimental = "true";
    };
  };
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    bluez5-experimental
    bluez-tools
    bluez-alsa
  ];
}
