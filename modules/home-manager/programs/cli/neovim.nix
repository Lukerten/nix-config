{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neovim.pvim;
in {
  options.programs.neovim.pvim = {
    enable = lib.mkEnableOption "pvim";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pvim;
      description = "The pvim package";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    programs.zoxide.enable = lib.mkDefault true;
  };
}
