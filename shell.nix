# Shell for bootstrapping flake-enabled nix and other tooling
{
  pkgs ? let
    lock =
      (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: {
  default = let
    add_wallpaper = pkgs.writeShellApplication {
      name = "add_wallpaper";
      text = builtins.readFile ./pkgs/wallpapers/single_image.sh;
    };
    get_wallpaper = pkgs.writeShellApplication {
      name = "get_wallpaper";
      text = builtins.readFile ./pkgs/wallpapers/preview-image.sh;
    };
    check_wallpaper = pkgs.writeShellApplication {
      name = "check_wallpaper";
      text = builtins.readFile ./pkgs/wallpapers/check-list.sh;
    };

  in
    pkgs.mkShell {
      NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
      nativeBuildInputs = with pkgs; [
        nix
        home-manager
        git
        sops
        ssh-to-age
        gnupg
        age
        get_wallpaper
        add_wallpaper
        check_wallpaper
      ];
    };
}
