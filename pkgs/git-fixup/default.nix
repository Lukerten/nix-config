{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "git-fixup";
  runtimeInputs = [git];
  text = builtins.readFile ./git-fixup.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
