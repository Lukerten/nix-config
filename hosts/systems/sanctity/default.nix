{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./services
    ./hardware-configuration.nix

    ../../global
    ../../users/luke
    ../../optional/fail2ban.nix
    ../../optional/tailscale-exit-node.nix
    ../../optional/nginx.nix
    ../../optional/mysql.nix
    ../../optional/postgres.nix
  ];
}
