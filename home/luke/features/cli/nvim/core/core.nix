{
  pkgs,
  config,
  lib,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in {
  xdg.configFile."nvim/color.vim".source = color;
  programs.neovim.extraConfig =
    # vim
    ''
      "Use system clipboard
      set clipboard=unnamedplus

      "Source colorscheme
      source ${color}

      "I hate vims folding
      set nofoldenable

      "Lets us easily trigger completion from binds
      set wildcharm=<tab>

      "Tabs
      set tabstop=2 "2 char-wide tab
      set expandtab "Use spaces
      set softtabstop=0 "Use same length as 'tabstop'
      set shiftwidth=0 "Use same length as 'tabstop'

      "4 char-wide overrides
      augroup four_space_tab
        autocmd!
        autocmd FileType markdown,text,mediawiki,plaintext,conf,ini,log setlocal tabstop=4 softtabstop=4 shiftwidth=4
      augroup END

      "Set tera to use htmldjango syntax
      augroup tera_htmldjango
        autocmd!
        autocmd BufRead,BufNewFile *.tera setfiletype htmldjango
      augroup END

      "Fix nvim size according to terminal
      "(https://github.com/neovim/neovim/issues/11330)
      augroup fix_size
        autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()
      augroup END

      "Line numbers
      set number

      "disable line wrap
      set nowrap
    '';

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
      vim.api.nvim_set_keymap('n', '<space>m', ':make', { noremap = true, desc = 'Make' })

      -- Loclist
      vim.api.nvim_set_keymap('n', '<space>l', ':lwindow<cr>', default_opts('Open loclist window' ))
      vim.api.nvim_set_keymap('n', '[l', ':lprev<cr>', default_opts('Previous loclist item' ))
      vim.api.nvim_set_keymap('n', ']l', ':lnext<cr>', default_opts('Next loclist item' ))

      vim.api.nvim_set_keymap('n', '<space>Ll', ':lhistory<cr>', default_opts('Open loclist history' ))
      vim.api.nvim_set_keymap('n', '[L', ':lolder<cr>', default_opts('Older loclist history' ))
      vim.api.nvim_set_keymap('n', ']L', ':lnewer<cr>', default_opts('Newer loclist history' ))

      -- Quickfix
      vim.api.nvim_set_keymap('n', '<space>q', ':cwindow<cr>', default_opts('Open quickfix window' ))
      vim.api.nvim_set_keymap('n', '[q', ':cprev<cr>', default_opts( 'Previous quickfix item' ))
      vim.api.nvim_set_keymap('n', ']q', ':cnext<cr>', default_opts('Next quickfix item' ))

      vim.api.nvim_set_keymap('n', '<space>Lq', ':chistory<cr>', default_opts('Open quickfix history' ))
      vim.api.nvim_set_keymap('n', '[Q', ':colder<cr>', default_opts('Older quickfix history' ))
      vim.api.nvim_set_keymap('n', ']Q', ':cnewer<cr>', default_opts('Newer quickfix history' ))

      -- Diagnostic
      vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, default_opts("Floating diagnostic" ))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, default_opts("Previous diagnostic" ))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, default_opts("Next diagnostic" ))
      vim.keymap.set("n", "gl", vim.diagnostic.setloclist, default_opts("Diagnostics on loclist" ))
      vim.keymap.set("n", "gq", vim.diagnostic.setqflist, default_opts( "Diagnostics on quickfix" ))

      vim.diagnostic.config({
        virtual_text = false
      })

      -- Show line diagnostics automatically in hover window
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
    '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-table-mode
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
