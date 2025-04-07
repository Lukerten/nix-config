{pkgs, ...}: let
  git-bare-clone = pkgs.writeShellScriptBin "git-bare-clone" "${builtins.readFile ./git-bare-clone.sh}";
  git-create-worktree = pkgs.writeShellScriptBin "git-create-worktree" "${builtins.readFile ./git-create-worktree.sh}";
  git-fixup = pkgs.writeShellScriptBin "git-fixup" "${builtins.readFile ./git-fixup.sh}";
  git-recent = pkgs.writeShellScriptBin "git-recent" "${builtins.readFile ./git-recent.sh}";
  git-track = pkgs.writeShellScriptBin "git-track" "${builtins.readFile ./git-track.sh}";
in {
  home.packages = [
    git-bare-clone
    git-create-worktree
    git-fixup
    git-recent
    git-track
    pkgs.gitflow
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      p = "pull --ff-only";
      sweep = "fetch --prune && branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d";
      ff = "merge --ff-only";
      graph = "log --decorate --oneline --graph";
      pushall = "!git remote | xargs -L1 git push --all";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    };
    userName = "Lucas Brendgen";
    userEmail = "lucas.brendgen@gmail.com";
    extraConfig = {init.defaultBranch = "main";};
    ignores = [".direnv" "result"];
    lfs.enable = true;
  };
}
