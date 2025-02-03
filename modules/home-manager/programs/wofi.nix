{pkgs, config, lib, ...}: let
  inherit (lib) mkEnableOption mkOption mkIf optionals types;
in {
  options.programs.wofi.emoji = {
    enable = mkEnableOption {
      default = false;
      description = "Enable emoji support in wofi.";
    };
    package = mkOption {
      default = pkgs.wofi-emoji;
      type = types.package;
      description = "The wofi package to use.";
    };
  };

  options.programs.wofi.pass = {
    enable = mkEnableOption {
      default = config.programs.password-store.enable;
      description = "Enable password-store integration in wofi.";
    };
    package = mkOption {
      default = pkgs.wofi-pass;
      type = types.package;
      description = "The wofi-pass package to use.";
    };
  };

  config = mkIf config.programs.wofi.enable {
    home.packages = let
      pass-wofi = config.programs.wofi.pass.package;
      emoji-wofi = config.programs.wofi.emoji.package;
    in
      optionals config.programs.wofi.pass.enable [ pass-wofi ] ++
      optionals config.programs.wofi.emoji.enable [ emoji-wofi ];
  };
}
