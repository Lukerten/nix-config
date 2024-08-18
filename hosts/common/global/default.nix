{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./cm4all-vpn.nix
      ./fish.nix
      ./font.nix
      ./gamemode.nix
      ./kdeconnect.nix
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./openssh.nix
      ./podman.nix
      ./sops.nix
      ./steam-hardware.nix
      ./systemd-initrd.nix
      ./upower.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "backup";
  };

  environment.systemPackages = with pkgs; [pciutils xorg.xrandr lshw killall];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?

  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  };
  services.pcscd.enable = true;
}
