{
  config,
  pkgs,
  ...
}: let
  # podman-stopall: stop all running containers
  # basically a prettier version of `podman stop $(podman ps -q)`
  podman-stopall = pkgs.writeShellScriptBin "podman-stopall" ''
    container_list=$(podman ps -q)
    if [ -n "$container_list" ]; then
      for container in $container_list; do
      printf "Stopping container: \033[32;1m%s\033[0m" $container
      podman stop $container > /dev/null
      printf " [\033[32;1mOK\033[0m]\n"
      done
    fi
    printf "All containers have stopped\n"
  '';

  # for compatability: add docker-stopall
  docker-stopall = pkgs.writeShellScriptBin "docker-stopall" ''
    container_list=$(docker ps -q)
    if [ -n "$container_list" ]; then
      for container in $container_list; do
      printf "Stopping container: \033[32;1m%s\033[0m" $container
      docker stop $container > /dev/null
      printf " [\033[32;1mOK\033[0m]\n"
      done
    fi
    printf "All containers have stopped\n"
  '';
in {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    extraPackages = [
      pkgs.podman-compose
    ];
  };
  environment.systemPackages = [
    podman-stopall
    docker-stopall
  ];
}
