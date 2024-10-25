{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./fish.nix
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
      ./thunar.nix
      ./upower.nix
      ./yubikey.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  # Fix for qt6 plugins
  # TODO: maybe upstream this?
  environment.profileRelativeSessionVariables = {
    QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
  };

  hardware.enableRedistributableFirmware = true;
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
