{
  description = "Lukes NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
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
    themes = {
      url = "github:Lukerten/themes";
      inputs.systems.follows = "systems";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-24_11.follows = "nixpkgs-stable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    deploy-rs,
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

    # NixOS configurations
    # ├─ annihilation: Main Laptop configuration
    # ├─ exaflare: Home Desktop configuration
    # ╰─ inception: Homelab Server configuration

    # Hosts
    nixosConfigurations = {
      annihilation = lib.nixosSystem {
        modules = [./hosts/systems/annihilation];
        specialArgs = {inherit inputs outputs;};
      };

      exaflare = lib.nixosSystem {
        modules = [./hosts/systems/exaflare];
        specialArgs = {inherit inputs outputs;};
      };

      inception = lib.nixosSystem {
        modules = [./hosts/systems/inception];
        specialArgs = {inherit inputs outputs;};
      };

      sanctity = lib.nixosSystem {
        modules = [./hosts/systems/sanctity];
        specialArgs = {inherit inputs outputs;};
      };
    };

    #  Home
    homeConfigurations = {
      "luke@annihilation" = lib.homeManagerConfiguration {
        modules = [./home/luke/annihilation.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "luke@exaflare" = lib.homeManagerConfiguration {
        modules = [./home/luke/exaflare.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "luke@inception" = lib.homeManagerConfiguration {
        modules = [./home/luke/exaflare.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "luke@sanctity" = lib.homeManagerConfiguration {
        modules = [./home/luke/sanctity.nix ./home/luke/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };

    # Deploy
    deploy.nodes = {
      inception = {
        hostname = "inception";
        sshUser = "luke";
        magicRollback = false;
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.inception;
        };
      };

      sanctity = {
        hostname = "sanctity";
        sshUser = "luke";
        magicRollback = false;
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.sanctity;
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
