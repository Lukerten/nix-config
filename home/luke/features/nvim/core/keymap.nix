{
  programs.neovim = {
    extraLuaConfig = # lua
      ''
        -- Scroll up and down
        vim.keymap.set("n", "<C-j>", "<C-e>", default_opts("Scroll down"))
        vim.keymap.set("n", "<C-k>", "<C-y>", default_opts("Scroll up"))
        vim.keymap.set("n", "<C-Up>", "<C-y>", default_opts("Scroll up"))
        vim.keymap.set("n", "<C-Down>", "<C-e>", default_opts("Scroll down"))

        -- Buffers
        vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next buffer", noremap=true, silent=true })
        vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>", { desc = "Previous buffer",noremap=true, silent=true })
      '';
  };
}
