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
    handlr-regex
    comma
    libnotify
    distrobox
    bc
    bottom
    eza
    zip
    unzip
    ripgrep
    fd
    httpie
    diffsitter
    jq
    timer
    tree
    ltex-ls
    nixd
    alejandra
    nvd
    nix-output-monitor
    nh
  ];

  programs = {
    dragon.enable = true;
    neofetch.enable = true;
    youtube-tui.enable = true;
  };
}
