{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
  hasSpecialisationCli = hasPackage "specialisation";
  hasAwsCli = hasPackage "awscli2";
  hasCliphistory = config.services.cliphist.enable;
  hasLazygit = hasPackage "lazygit";
  hasNeovim = config.programs.neovim.enable;
  hasNeomutt = config.programs.neomutt.enable;
  hasTmux = config.programs.tmux.enable;
  hasBat = config.programs.bat.enable;
  hasEza = config.programs.eza.enable;
  hasRipgrep = config.programs.ripgrep.enable;
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
    jqless = "jq -C | less -r";
    shut = "sudo shutdown -h now";
    lg = mkIf hasLazygit "lazygit";
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
    clipboard = mkIf hasCliphistory "cliphist-fzf";
    awssw = aws-switch;

    grep = mkIf hasRipgrep "rg";
    cat = mkIf hasBat "bat";
    ls = mkIf hasEza "exa";
    ll = mkIf hasEza "exa -l";
    la = mkIf hasEza "exa -la";
    lt = mkIf hasEza "exa --icons --tree -a";
    l = ls;
    tree = lt;
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
    ripgrep.enable = true;
    zoxide.enable = true;
    thefuck.enable = true;
    thefuck.enableInstantMode = true;
  };

  # Extra Terminal Utilities
  home = {
    sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
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
      p7zip
      neovim
    ];
  };
}
