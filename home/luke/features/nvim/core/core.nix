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

      "Loclist
      nmap <space>l :lwindow<cr>
      nmap [l :lprev<cr>
      nmap ]l :lnext<cr>

      nmap <space>L :lhistory<cr>
      nmap [L :lolder<cr>
      nmap ]L :lnewer<cr>

      "Quickfix
      nmap <space>q :cwindow<cr>
      nmap [q :cprev<cr>
      nmap ]q :cnext<cr>

      nmap <space>Q :chistory<cr>
      nmap [Q :colder<cr>
      nmap ]Q :cnewer<cr>
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

      function default_opts( desc, buffnr )
        return { noremap = true, silent = true, desc = desc, buffer = buffnr }
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
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next buffer", noremap=true, silent=true })
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>", { desc = "Previous buffer",noremap=true, silent=true })
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
