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
  hasLazygit = hasPackage "lazygit";
  hasNeovim = config.programs.neovim.enable;
  hasNeomutt = config.programs.neomutt.enable;
  hasEza = config.programs.eza.enable;
  hasBat = config.programs.bat.enable;
  hasTmux = config.programs.tmux.enable;
in {
  home.shellAliases = rec {
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
    susu = "sudo su";
    op = "xdg-open";
    del = "rm -rf";
    sdel = "sudo rm -rf";
    null = "/dev/null";
    jqless = "jq -C | less -r";
    shut = "sudo shutdown -h now";
    grep = mkIf hasRipgrep "rg";
    lg = mkIf hasLazygit "lazygit";
    ls = mkIf hasEza "exa --icons -a";
    ll = mkIf hasEza "exa --icons -la";
    la = mkIf hasEza "exa --icons -a";
    lt = mkIf hasEza "exa --icons --tree -a";
    l = ls;
    tree = lt;
    cat = mkIf hasBat "bat";
    tmux = mkIf hasTmux "tmux -u";
    tua = mkIf hasTmux "tmux a -t";
    tu = tmux;
    ta = tua;
    s = mkIf hasSpecialisationCli "specialisation";
    vim = mkIf hasNeovim "nvim";
    mutt = mkIf hasNeomutt "neomutt";
    v = vim;
    vi = vim;
    m = mutt;
    aws-switch = mkIf hasAwsCli "export AWS_PROFILE=(aws configure list-profiles | fzf)";
    awssw = aws-switch;
  };

  programs = {
    btop.enable = true;
    bash.enable = true;
    bat = {
      enable = true;
      config = {theme = "base16";};
    };
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

  # Extra Terminal Utilities
  home.packages = with pkgs; [
    comma # Install and run programs by adding a , in front
    distrobox # Nice escape hatch, integrates docker images with my environment
    dnsutils # dig
    extra-container # Run declarative containers without full system rebuilds
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
    alejandra # default nix formatter
    nix-diff # differ
    nix-health # health checker
    nh # home-manager & nixos wrapper
    nix-index # index nix packages
    just # justfile
  ];
}
