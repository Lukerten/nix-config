{pkgs, ...}: {
  programs.wireshark = {
    package = pkgs.wireshark;
    enable = true;
  };
  users.groups.wireshark = {
    name = "wireshark";
    gid = 500;
  };
}
