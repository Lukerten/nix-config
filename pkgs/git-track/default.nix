{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "git-track";
  runtimeInputs = [git];
  text = builtins.readFile ./git-track.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
