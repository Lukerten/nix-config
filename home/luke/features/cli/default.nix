{
  imports = [
    ./fish
    ./nushell
    ./starship
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

  programs = {
    btop.enable = true;
    bash.enable = true;
    bat = {
      enable = true;
      config = {theme = "base16";};
    };
    cm4all-vpn.enable = true;
    fzf = {
      enable = true;
      defaultOptions = ["--color 16"];
    };
    jq.enable = true;
    pfetch.enable = true;
    ranger.enable = true;
    zoxide.enable = true;
  };
}
