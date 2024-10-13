{pkgs, ...}: {
  imports = [
    ./fish
    ./nushell
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./jujutsu.nix
    ./nix-index.nix
    ./pass.nix
    ./shellcolor.nix
    ./ssh.nix
    ./terminal.nix
    ./tmux.nix
  ];
}
