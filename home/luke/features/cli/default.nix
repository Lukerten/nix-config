{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./direnv.nix
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

  programs = {
    bat = {
      enable = true;
      config = {theme = "base16";};
    };
    bash.enable = true;
    cm4all-vpn.enable = true;
    fzf = {
      enable = true;
      defaultOptions = ["--color 16"];
    };
    jq.enable = true;
    pfetch.enable = true;
    zoxide.enable = true;
  };
}
