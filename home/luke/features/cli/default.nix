{
  imports = [
    ./fish
    ./nushell
    ./nvim
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./jujutsu.nix
    ./nix-index.nix
    ./pass.nix
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
    eza.enable = true;
    fzf = {
      enable = true;
      defaultOptions = ["--color 16"];
    };
    jq.enable = true;
    pfetch.enable = true;
    ranger.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
