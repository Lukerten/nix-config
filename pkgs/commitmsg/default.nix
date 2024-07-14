{ lib, writeShellApplication, curl, }:
(writeShellApplication {
  name = "commitmsg";
  runtimeInputs = [ curl ];
  text = builtins.readFile ./commitmsg.sh;
}) // {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}

