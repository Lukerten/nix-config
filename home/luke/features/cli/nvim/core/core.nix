{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim.extraLuaConfig =
    # lua
    ''
      function add_sign(name, text)
        vim.fn.sign_define(name, { text = text, texthl = name, numhl = name})
      end

      function default_opts( desc )
        return { noremap = true, silent = true, desc = desc }
      end

      add_sign("DiagnosticSignError", "󰅚 ")
      add_sign("DiagnosticSignWarn", " ")
      add_sign("DiagnosticSignHint", "󰌶 ")
      add_sign("DiagnosticSignInfo", " ")

      -- Scroll up and down
      vim.keymap.set("n", "<C-j>", "<C-e>", default_opts("Scroll down"))
      vim.keymap.set("n", "<C-k>", "<C-y>", default_opts("Scroll up"))
      vim.keymap.set("n", "<C-Up>", "<C-y>", default_opts("Scroll up"))
      vim.keymap.set("n", "<C-Down>", "<C-e>", default_opts("Scroll down"))

      -- Buffers
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>",default_opts("Next buffer"))
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>",default_opts("Previous buffer"))

      -- Make
      vim.api.nvim_set_keymap('n', '<leader>m', ':make', { noremap = true, desc = 'Make' })

      -- Loclist
      vim.api.nvim_set_keymap('n', '<leader>l', ':lwindow<cr>', default_opts('Open loclist window' ))
      vim.api.nvim_set_keymap('n', '[l', ':lprev<cr>', default_opts('Previous loclist item' ))
      vim.api.nvim_set_keymap('n', ']l', ':lnext<cr>', default_opts('Next loclist item' ))

      vim.api.nvim_set_keymap('n', '<leader>Ll', ':lhistory<cr>', default_opts('Open loclist history' ))
      vim.api.nvim_set_keymap('n', '[L', ':lolder<cr>', default_opts('Older loclist history' ))
      vim.api.nvim_set_keymap('n', ']L', ':lnewer<cr>', default_opts('Newer loclist history' ))

      -- Quickfix
      vim.api.nvim_set_keymap('n', '<leader>q', ':cwindow<cr>', default_opts('Open quickfix window' ))
      vim.api.nvim_set_keymap('n', '[q', ':cprev<cr>', default_opts( 'Previous quickfix item' ))
      vim.api.nvim_set_keymap('n', ']q', ':cnext<cr>', default_opts('Next quickfix item' ))

      vim.api.nvim_set_keymap('n', '<leader>Lq', ':chistory<cr>', default_opts('Open quickfix history' ))
      vim.api.nvim_set_keymap('n', '[Q', ':colder<cr>', default_opts('Older quickfix history' ))
      vim.api.nvim_set_keymap('n', ']Q', ':cnewer<cr>', default_opts('Newer quickfix history' ))

      -- Diagnostic
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, default_opts("Floating diagnostic" ))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, default_opts("Previous diagnostic" ))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, default_opts("Next diagnostic" ))
      vim.keymap.set("n", "gl", vim.diagnostic.setloclist, default_opts("Diagnostics on loclist" ))
      vim.keymap.set("n", "gq", vim.diagnostic.setqflist, default_opts( "Diagnostics on quickfix" ))

      -- Terminal
      function _G.OpenMultipleTerminalsInNewTab()
        vim.cmd("tabnew")
        vim.cmd("terminal")
        vim.cmd("vsplit")
        vim.cmd("terminal")
        vim.cmd("split")
        vim.cmd("terminal")
      end

      function _G.OpenDoubleTerminalsInNewTab()
        vim.cmd("tabnew")
        vim.cmd("terminal")
        vim.cmd("vsplit")
        vim.cmd("terminal")
      end

      vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", {desc = "Exit terminal mode"})
      vim.keymap.set("n", "<leader>Tv", "<cmd>vsplit | terminal<cr>", {desc = "Open vertical split terminal"})
      vim.keymap.set("n", "<leader>Th", "<cmd>split | terminal<cr>", {desc = "Open horizontal split terminal"})
      vim.keymap.set("n", "<leader>Tt", "<cmd>lua OpenDoubleTerminalsInNewTab()<cr>", {desc = "Open terminal in new tab"})
      vim.keymap.set("n", "<leader>Tm", "<cmd>lua OpenMultipleTerminalsInNewTab()<cr>", {desc = "Open terminal in new tab"})
      vim.keymap.set("n", "<leader>t", "<cmd>split | terminal<cr>", {desc = "Open terminal"})
      vim.diagnostic.config({
        virtual_text = false
      })

      -- Show line diagnostics automatically in hover window
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

      -- Move line up and down
      vim.api.nvim_set_keymap('n', 'K', '<cmd>m .-2<CR>==', { noremap = true, silent = true, desc = 'Move line up' })
      vim.api.nvim_set_keymap('n', 'J', '<cmd>m .+1<CR>==', { noremap = true, silent = true, desc = 'Move line down' })

    '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    editorconfig-nvim
    vim-surround
    {
      plugin = nvim-autopairs;
      type = "lua";
      config =
        # lua
        ''
          require('nvim-autopairs').setup{}
        '';
    }
  ];
}
