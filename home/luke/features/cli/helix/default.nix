{
  config,
  pkgs,
  ...
}: let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
in {
  imports = [
    ./languages.nix
    ./keymap.nix
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "nix-${hash}";
      editor = {
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    themes."nix-${hash}" = import ./theme.nix {inherit colorscheme;};
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
