{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./jujutsu.nix
    ./nix-index.nix
    ./nushell.nix
    ./pass.nix
    ./ranger.nix
    ./shellcolor.nix
    ./ssh.nix
    ./starship.nix
    ./terminal.nix
    ./tmux.nix
  ];
}
