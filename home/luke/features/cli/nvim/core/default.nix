{
  pkgs,
  config,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
  reloadNvim = ''
    XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
    for server in $XDG_RUNTIME_DIR/nvim.*; do
    nvim --server $server --remote-send '<Esc>:source $MYVIMRC<CR>' &
    done
  '';
in {
  imports = [./autocmd.nix ./core.nix ./jj.nix];

  xdg.configFile."nvim/color.vim".source = color;
  xdg.configFile."nvim/color.vim".onChange = reloadNvim;
  programs.neovim.extraConfig =
    # vim
    ''
      "Source colorscheme
      source ${color}

      "Use system clipboard
      set clipboard=unnamedplus

      "Tabs
      set tabstop=2 "2 char-wide tab
      set softtabstop=0 "Use same length as 'tabstop'
      set shiftwidth=0 "Use same length as 'tabstop'
      set expandtab "Use spaces

      "Line numbers
      set number

      "disable line wrap
      set nowrap
      set nofoldenable

      "Highlight search
      set cmdheight=1
      set wildcharm=<tab>

      "Timouts
      set updatetime=1
      set shortmess+=c
      set tm=500
      set hidden

      "Disable swap and backup files
      set noswapfile
      set nobackup
      set nowritebackup

      "Disable Bell"
      set noerrorbells
      set novisualbell

      "Split Right and Below
      set splitright
      set splitbelow

      "set Leader Key to space
      let mapleader=" "
      let maplocalleader=" "

      "disabe mouse and arrow keys
      set mouse=
      noremap <Up> <Nop>
      noremap <Down> <Nop>
      noremap <Left> <Nop>
      noremap <Right> <Nop>
    '';
}
