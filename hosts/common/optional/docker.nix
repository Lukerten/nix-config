{pkgs, ...}: let 
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
in{
  virtualisation.docker = {
    enable = true;
  };
    environment.systemPackages = [
    docker-stopall
  ];
}
