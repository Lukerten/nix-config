{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [{
    plugin = lazygit-nvim;
    type = "lua";
    config = # lua
      ''
        vim.keymap.set("n", "<space>g", "<cmd>LazyGit<cr>", {desc="LazyGit"});
        vim.keymap.set("n", "<space>Go", "<cmd>Telescope git_status<cr>", {desc="Git Status"});
        vim.keymap.set("n", "<space>Gb", "<cmd>Telescope git_branches<cr>", {desc="Git Branches"});
        vim.keymap.set("n", "<space>Gc", "<cmd>Telescope git_commits<cr>", {desc="Git Commits"});
      '';
  }];
}
