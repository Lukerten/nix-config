{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
  hasRipgrep = hasPackage "ripgrep";
  hasSpecialisationCli = hasPackage "specialisation";
  hasAwsCli = hasPackage "awscli2";
  hasNeovim = config.programs.neovim.enable;
  hasEmacs = config.programs.emacs.enable;
  hasNeomutt = config.programs.neomutt.enable;
in {
  home.shellAliases = rec {
    jqless = "jq -C | less -r";
    n = "nix";
    ns = "nix shell";
    nsn = "nix shell nixpkgs#";
    nb = "nix build";
    nbn = "nix build nixpkgs#";
    nf = "nix flake";
    nr = "nixos-rebuild --flake .";
    nrs = "nixos-rebuild --flake . switch";
    snr = "nixos-rebuild --flake .";
    snrs = "nixos-rebuild --flake . switch";
    hm = "home-manager --flake .";
    hms = "home-manager --flake . switch";
    grep = mkIf hasRipgrep "rg";
    s = mkIf hasSpecialisationCli "specialisation";
    e = mkIf hasEmacs "emacsclient -t";
    vim = mkIf hasNeovim "nvim";
    vi = vim;
    v = vim;
    mutt = mkIf hasNeomutt "neomutt";
    m = mutt;
    aws-switch = mkIf hasAwsCli "export AWS_PROFILE=(aws configure list-profiles | fzf)";
    awssw = aws-switch;
    ll = "ls -l";
    la = "ls -la";
    l = "ls";
  };

  # Extra Terminal Utilities
  home.packages = with pkgs; [
    comma # Install and run programs by adding a , in front
    distrobox # Nice escape hatch, integrates docker images with my environment
    dnsutils # dig
    ncdu # TUI disk usage
    zip # Compression
    unzip # Decompression
    ripgrep # Search using better grep
    fd # Find using better find
    sd # Search and replace using better sed
    moreutils # ts, etc
    httpie # Better curl
    diffsitter # Better diff
    timer # Timer
    tree # Directory tree
    alejandra # default nix formatter
    nix-diff # differ
    nh # home-manager & nixos wrapper
  ];
}
