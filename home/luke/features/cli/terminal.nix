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
  hasExa = hasPackage "eza";
  hasSpecialisationCli = hasPackage "specialisation";
  hasNeovim = config.programs.neovim.enable;
  hasKitty = config.programs.kitty.enable;
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
    cik = mkIf hasKitty "clone-in-kitty --type os-window";
    s = mkIf hasSpecialisationCli "specialisation";
    grep = mkIf hasRipgrep "rg";
    vim = mkIf hasNeovim "nvim";
    vi = vim;
    v = vim;
    ll = "ls -l";
    la = "ls -la";
    l = "ls";
  };

  # Extra Terminal Utilities
  home.packages = with pkgs; [
    comma # Install and run programs by adding a , in front
    distrobox # Nice escape hatch, integrates docker images with my environment
    ncdu # TUI disk usage
    eza # Better ls
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

