{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "󰐊";
          topdelete.text = "󰐊";
          changedelete.text = "󰐊";
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>Gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Stage Hunk";
        };
      }

      {
        mode = "n";
        key = "<leader>Gr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
        options = {
          silent = true;
          desc = "Reset Hunk";
        };
      }

      {
        mode = "v";
        key = "<leader>Gs";
        action = "<cmd>lua function() Gitsigns stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end<CR>";
        options = {
          silent = true;
          desc = "Stage Hunk";
        };
      }

      {
        mode = "v";
        key = "<leader>Gr";
        action = "function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end";
        options = {
          silent = true;
          desc = "Reset Hunk";
        };
      }

      {
        mode = "n";
        key = "<leader>GS";
        action = "<cmd>Gitsigns stage_buffer<CR>";
        options = {
          silent = true;
          desc = "Stage Buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>Gu";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          silent = true;
          desc = "Undo Stage Hunk";
        };
      }

      {
        mode = "n";
        key = "<leader>GR";
        action = "<cmd> Gitsigns reset_buffer<CR>";
        options = {
          silent = true;
          desc = "Reset Buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>Gp";
        action = "<cmd> Gitsigns preview_hunk<CR>";
        options = {
          silent = true;
          desc = "Preview Hunk";
        };
      }

      {
        mode = "n";
        key = "<leader>Gb";
        action = "<cmd> Gitsigns toggle_current_line_blame<CR>";
        options = {
          silent = true;
          desc = "Blame";
        };
      }

      {
        mode = "n";
        key = "<leader>Gd";
        action = "<cmd> Gitsigns diffthis<CR>";
        options = {
          silent = true;
          desc = "Diff";
        };
      }
    ];
  };
}
