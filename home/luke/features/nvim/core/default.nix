{ pkgs, config, ... }:
let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
  reloadNvim = ''
    XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
    for server in $XDG_RUNTIME_DIR/nvim.*; do
    nvim --server $server --remote-send '<Esc>:source $MYVIMRC<CR>' &
    done
  '';
in {
  imports = [ ./autocmd.nix ./core.nix ];

  xdg.configFile."nvim/color.vim".source = color;
  xdg.configFile."nvim/color.vim".onChange = reloadNvim;
  programs.neovim.extraConfig = # vim
    ''
      "Source colorscheme
      source ${color}
    '';
}
