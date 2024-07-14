{
  description = "Your new nix config";

  inputs = {
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:misterio77/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";

    nix = {
      url = "github:nixos/nix/2.21-maintenance";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hydra = {
      url = "github:nixos/hydra";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.nix.follows = "nix";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
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
    matugen = {
      url = "github:misterio77/matugen/overridable-systems";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      templates = import ./templates;
      overlays = import ./overlays { inherit inputs outputs; };

      # Hydra
      hydraJobs = import ./hydra.nix { inherit inputs outputs; };
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild switch --flake .#your-hostname'
      nixosConfigurations = {
        # Main Laptop configuration
        annihilation = lib.nixosSystem {
          modules = [ ./hosts/annihilation ];
          specialArgs = { inherit inputs outputs; };
        };

        # Home Desktop configuration
        exaflare = lib.nixosSystem {
          modules = [ ./hosts/exaflare ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #  Home Manager configuration
      homeConfigurations = {
        #  # Main Laptop configuration
        "luke@annihilation" = lib.homeManagerConfiguration {
          modules = [ ./home/luke/annihilation.nix ];
          pkgs = pkgsFor."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # Home Desktop configuration
        "luke@exaflare" = lib.homeManagerConfiguration {
          modules = [ ./home/luke/exaflare.nix ];
          pkgs = pkgsFor."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
