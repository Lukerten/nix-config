{pkgs, ...}: {
  home.packages = with pkgs; [
    git-bare-clone
    git-create-worktree
    git-fixup
    git-recent
    git-track
    gitflow
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
