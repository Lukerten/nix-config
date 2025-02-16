{pkgs, ...}: {
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.obsidian-nvim;
      type = "lua";
      config =
        # lua
        ''
          vim.api.nvim_set_keymap('n', '<leader>Nn', '<cmd>ObsidianNew<CR>', { noremap = true, silent = true , desc = "New note" })
          vim.api.nvim_set_keymap('n', '<leader>Nf', '<cmd>ObsidianSearch<CR>', { noremap = true, silent = true, desc = "Search notes" })
          vim.api.nvim_set_keymap('n', '<leader>Nw', '<cmd>ObsidianWorkspace<CR>', { noremap = true, silent = true , desc = "Change workspace" })
          vim.api.nvim_set_keymap('n', '<leader>Ng', '<cmd>ObsidianFollowLink<CR>', { noremap = true, silent = true , desc = "Follow link" })

          require("obsidian").setup({
            workspaces = {
              {
                name = "personal",
                path = "~/Documents/notes/private",
              },
              {
                name = "work",
                path = "~/Documents/notes/work",
              },
              {
                name = "student",
                path = "~/Documents/notes/student",
              },
            },
            completion = {
              nvim_cmp = true,
              min_chars = 2,
            },
            mappings = {
              ["<leader>Oc"] = {
                action = function()
                  return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
              },
              ["<Os>"] = {
                action = function()
                  return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
              }
            },
            preferred_link_style = "wiki",
            picker = {
              note_mappings = {
                name = "telescope.nvim",
                new = "<C-x>",
                insert_link = "<C-l>",
              },
              tag_mappings = {
                tag_note = "<C-x>",
                insert_tag = "<C-l>",
              },
            },
          })
        '';
    }
  ];
}
