{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "git-bare-clone";
  runtimeInputs = [git];
  text = builtins.readFile ./git-bare-clone.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
