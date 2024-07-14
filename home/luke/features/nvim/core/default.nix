{ pkgs, config, ... }:
let color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);

in {
  xdg.configFile."nvim/color.vim".source = color;
  programs.neovim.extraConfig = # vim
    ''
      "Use system clipboard
      set clipboard=unnamedplus
      "Source colorscheme
      source ${color}

      "Lets us easily trigger completion from binds
      set wildcharm=<tab>

      "Set fold level to highest in file
      "so everything starts out unfolded at just the right level
      augroup initial_fold
        autocmd!
        autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
      augroup END

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

      "Options when composing mutt mail
      augroup mail_settings
        autocmd FileType mail set noautoindent wrapmargin=0 textwidth=0 linebreak wrap formatoptions +=w
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

      "Scroll up and down
      nmap <C-j> <C-e>
      nmap <C-k> <C-y>
      nmap <C-Up> <C-y>
      nmap <C-Down> <C-e>

      "AutoClose Terminal
      augroup AutoCloseTerminal
        autocmd!
        autocmd BufLeave * if &buftype ==# 'terminal' | execute 'bdelete!' | endif
      augroup END

      "AutoClose NvimTree"
      augroup AutoCloseNvimTree
        autocmd!
        autocmd BufLeave * if &buftype ==# 'NvimTree' | execute 'NvimTreeClose' | endif
      augroup END
    '';

  programs.neovim.extraLuaConfig = # lua
    ''
      function add_sign(name, text)
        vim.fn.sign_define(name, { text = text, texthl = name, numhl = name})
      end

      add_sign("DiagnosticSignError", "󰅚 ")
      add_sign("DiagnosticSignWarn", " ")
      add_sign("DiagnosticSignHint", "󰌶 ")
      add_sign("DiagnosticSignInfo", " ")

      -- Buffers
      vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next buffer", noremap=true, silent=true })
      vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>", { desc = "Previous buffer",noremap=true, silent=true })

      -- LSP
      vim.keymap.set("n", "<space>Lgc", "<cmd> lua vim.lsp.buf.declaration()<cr>",              { desc = "Go to declaration",        noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgd", "<cmd> lua vim.lsp.buf.definition()<cr>",               { desc = "Go to definition",         noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgt", "<cmd> lua vim.lsp.buf.type_definition()<cr>",          { desc = "Go to type definition",    noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgr", "<cmd> lua vim.lsp.buf.references()<cr>",               { desc = "Go to references",         noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgn", "<cmd> lua vim.lsp.diagnostic.goto_next()<cr>",         { desc = "Go to next diagnostic",    noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgp", "<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>",         { desc = "Go to previous diagnostic",noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lgi", "<cmd> lua vim.lsp.buf.implementation()<cr>",           { desc = "Go to implementation",     noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lwa", "<cmd> lua vim.lsp.buf.add_workspace_folder()<cr>",     { desc = "Add workspace folder",     noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lwr", "<cmd> lua vim.lsp.buf.remove_workspace_folder()<cr>",  { desc = "Remove workspace folder",  noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lwl", "<cmd> lua vim.lsp.buf.list_workspace_folders()<cr>",   { desc = "List workspace folders",   noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lh", "<cmd> lua vim.lsp.buf.hover()<cr>",                     { desc = "Hover Documentation",      noremap=true, silent=true })
      vim.keymap.set("n", "<space>Ls", "<cmd> lua vim.lsp.buf.signature_help()<cr>",            { desc = "Signature help",           noremap=true, silent=true })
      vim.keymap.set("n", "<space>Lr", "<cmd> lua vim.lsp.buf.rename()<cr>",                    { desc = "Rename",                   noremap=true, silent=true })
      vim.keymap.set("n", "<space>l", "<cmd> lua vim.lsp.buf.format()<cr>",                 { desc = "Format code",              noremap=true, silent=true })
      vim.keymap.set("v", "<space>l", "<cmd> lua vim.lsp.buf.format()<cr>",                 { desc = "Format code",              noremap=true, silent=true })

      -- Telescope
      vim.keymap.set("n", "<space>f", "<cmd> Telescope find_files<cr>",   {desc="Find files", noremap=true, silent=true});
      vim.keymap.set("n", "<space>d", "<cmd> Telescope live_grep<cr>",    {desc="Live grep", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hb", "<cmd>Telescope git_branches<cr>", {desc="Git branches", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hh", "<cmd>Telescope help_tags<cr>",    {desc="Help tags", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hm", "<cmd>Telescope man_pages<cr>",    {desc="Man pages", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Ho", "<cmd>Telescope oldfiles<cr>",     {desc="Old files", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hr", "<cmd>Telescope registers<cr>",    {desc="Registers", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hk", "<cmd>Telescope keymaps<cr>",      {desc="Keymaps", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Hc", "<cmd>Telescope commands<cr>",     {desc="Commands", noremap=true, silent=true});

      -- Nvim-tree
      vim.keymap.set("n", "<space>Ee", "<cmd>NvimTreeToggle<cr>",   {desc="Toggle NvimTree", noremap=true, silent=true});
      vim.keymap.set("n", "<space>EE", "<cmd>NvimTreeToggle<cr>",   {desc="Toggle NvimTree", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Er", "<cmd>NvimTreeRefresh<cr>",  {desc="Refresh NvimTree", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Ef", "<cmd>NvimTreeFindFile<cr>", {desc="Find file in NvimTree", noremap=true, silent=true});
      vim.keymap.set("n", "<space>e" , "<cmd>NvimTreeFocus<cr>",    {desc="Focus NvimTree", noremap=true, silent=true});

      -- Trouble
      vim.keymap.set("n", "<space>Tt", "<cmd>Trouble diagnostics toggle<CR>",               {desc="Toggle diagnostics", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Td", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",  {desc="Workspace diagnostics", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Ts", "<cmd>Trouble symbols togglefocus=false<CR>",        {desc="LSP symbols", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Tl", "<cmd>Trouble loclist toggle<CR>",                   {desc="loclist", noremap=true, silent=true});
      vim.keymap.set("n", "<space>Tq", "<cmd>Trouble qflist toggle<CR>",                    {desc="quickfix list", noremap=true, silent=true});

      -- Kommentary
      vim.api.nvim_set_keymap("x", "<space>c", "<Plug>kommentary_visual_default",       {desc = "Comment line"})
      vim.api.nvim_set_keymap("v", "<space>c", "<Plug>kommentary_visual_default<C-c>",  {desc = "Comment line"})

      -- utils
      vim.keymap.set("n", "<space>o", "<cmd>only<cr>",        {desc="Close all other windows",  noremap=true, silent=true});
      vim.keymap.set("n", "<space>w", "<cmd>w<cr>",           {desc="Save",                     noremap=true, silent=true});
      vim.keymap.set("n", "<space>q", "<cmd>q<cr>",           {desc="Quit",                     noremap=true, silent=true});
      vim.keymap.set("n", "<space>m", "<cmd>Make<cr>", {desc="Make", noremap=true, silent=true});
    '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-table-mode
    editorconfig-nvim
    vim-surround
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = # lua
        ''
          require('nvim-autopairs').setup{}
        '';
    }
  ];
}
