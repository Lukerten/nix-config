{
  description = "Lukes NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";

    themes = {
      url = "github:Lukerten/themes";
      inputs.systems.follows = "systems";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:viperml/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tools and utilities
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    templates = import ./templates;
    overlays = import ./overlays {inherit inputs outputs;};
    hydraJobs = import ./hydra.nix {inherit inputs outputs;};
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    # NixOS configuration entrypoint
    nixosConfigurations = {
      # Main Laptop configuration
      annihilation = lib.nixosSystem {
        modules = [./hosts/systems/annihilation];
        specialArgs = {inherit inputs outputs;};
      };

      # Home Desktop configuration
      exaflare = lib.nixosSystem {
        modules = [./hosts/systems/exaflare];
        specialArgs = {inherit inputs outputs;};
      };
    };

    #  Home Manager configuration
    homeConfigurations = {
      #  # Main Laptop configuration
      "luke@annihilation" = lib.homeManagerConfiguration {
        modules = [./home/luke/annihilation.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      # Home Desktop configuration
      "luke@exaflare" = lib.homeManagerConfiguration {
        modules = [./home/luke/exaflare.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
