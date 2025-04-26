{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./locale.nix
      ./nix-ld.nix
      ./nix.nix
      ./openssh.nix
      ./prometheus-node-exporter.nix
      ./sops.nix
      ./systemd-initrd.nix
      ./tailscale.nix

      inputs.home-manager.nixosModules.home-manager
    ]
    ++ (builtins.attrValues outputs.nixosModules);
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {allowUnfree = true;};
  };

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  environment = {
    profileRelativeSessionVariables = {
      QT_PLUGIN_PATH = ["/lib/qt-6/plugins"];
    };
    systemPackages = with pkgs; [
      libnma
    ];
  };

  hardware.enableRedistributableFirmware = true;
  services.pcscd.enable = true;
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
