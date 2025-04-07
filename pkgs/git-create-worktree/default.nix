{
  lib,
  writeShellApplication,
  git,
}:
(writeShellApplication {
  name = "git-create-worktree";
  runtimeInputs = [git];
  text = builtins.readFile ./git-create-worktree.sh;
})
// {
  meta = with lib; {
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
