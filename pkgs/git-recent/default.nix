{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "git-recent";
  runtimeInputs = [git];
  text = builtins.readFile ./git-recent.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
