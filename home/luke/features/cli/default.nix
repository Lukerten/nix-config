{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./cmatrix.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./jujutsu.nix
    ./nix-index.nix
    ./ranger.nix
    ./screen.nix
    ./shellcolor.nix
    ./ssh.nix
    ./starship
  ];

  home.packages = with pkgs; [
    comma             # Install and run programs by adding a , in front
    distrobox         # Nice escape hatch, integrates docker images with my environment

    bc                # Calculator
    ncdu              # TUI disk usage
    eza               # Better ls
    zip               # Compression
    unzip             # Decompression
    ripgrep           # Search using better grep
    fd                # Find using better find
    httpie            # Better curl
    diffsitter        # Better diff
    jq                # JSON processor and pretty printer
    timer             # Timer
    tree              # Directory tree

    # Nix Stuff:
    alejandra         # default nix formatter
    nix-diff          # differ
    nh                # home-manager & nixos wrapper
  ];

  programs = {
    dragon.enable = true;
    neofetch.enable = true;
    cm4all-vpn.enable = true;
    youtube-tui.enable = true;
  };
}
