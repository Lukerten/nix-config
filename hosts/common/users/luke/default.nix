{ pkgs, config, ... }:
let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.luke = {
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "password";
    home = "/home/luke";
    extraGroups = [ "wheel" "video" "audio" ] ++ ifTheyExist [
      "minecraft"
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "openrazer"
      "libvirtd"
      "deluge"
    ];

    # openssh.authorizedKeys.keys = [ (builtins.readFile
    # ../../../../home/luke/ssh.pub) ];
    # hashedPasswordFile = config.sops.secrets.luke-password.path;
    packages = [ pkgs.home-manager ];
  };

  #  sops.secrets.luke-password = {
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  # };

  home-manager.users.luke =
    import ../../../../home/luke/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
