{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./docker.nix
    ./fish.nix
    ./font.nix
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./prometeus-node-exporter.nix
    ./systemd-initrd.nix
    ./sops.nix
    ./steam-hardware.nix
    ./gamemode.nix
    ./podman.nix
    ./tailscale.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
  };

  environment.systemPackages = with pkgs; [ pciutils xorg.xrandr lshw killall ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = { allowUnfree = true; };
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?

  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = [ "/lib/qt-6/plugins" ];
  };
  services.pcscd.enable = true;
}
