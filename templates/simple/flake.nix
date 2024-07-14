{
  description = "FS-AI Protokoll";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; };

  outputs = { nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      pkgsFor = nixpkgs.legacyPackages;
    in {
      devShells = forAllSystems
        (system: { default = pkgsFor.${system}.callPackage ./shell.nix { }; });
    };
}

