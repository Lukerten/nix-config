{
  imports = [./package.nix ./traefik.nix];
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "luke";
  };
}
