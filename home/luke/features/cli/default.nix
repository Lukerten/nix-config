{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./cava.nix
    ./cmatrix.nix
    ./direnv.nix
    ./dragon.nix
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
    ./starship.nix
    ./tmux.nix
    ./xpo.nix
  ];

  home.packages = with pkgs; [
    comma
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
    commitmsg
    nixd
    alejandra
    nvd
    nix-output-monitor
    nh
  ];

  programs = {
    youtube-tui.enable = true;
    neofetch.enable = true;
  };
}
