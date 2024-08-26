{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.programs.messager;
in {
  options.programs.messager = {
    whatsapp = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable WhatsApp messager";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.whatsapp-for-linux;
        description = "WhatsApp messager package";
      };
    };

    signal = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the Signal messager";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.signal-desktop;
        description = "Signal messager package";
      };
    };

    slack = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Slack";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.slack;
        description = "Slack messager package";
      };
    };

    element = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Element";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.element-desktop;
        description = "Element messager package";
      };
    };

    webex = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Webex";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.webex;
        description = "Webex messager package";
      };
    };

    teams = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Teams";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.teams;
        description = "Teams package";
      };
    };

    teamspeak = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Teamspeak";
      };
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.pkgs.teamspeak_client;
        description = "Teamspeak package";
      };
    };
  };

  config.home.packages =
    lib.optional cfg.whatsapp.enable cfg.whatsapp.package
    ++ lib.optional cfg.signal.enable cfg.signal.package
    ++ lib.optional cfg.slack.enable cfg.slack.package
    ++ lib.optional cfg.element.enable cfg.element.package
    ++ lib.optional cfg.webex.enable cfg.webex.package
    ++ lib.optional cfg.teams.enable cfg.teams.package
    ++ lib.optional cfg.teamspeak.enable cfg.teamspeak.package;
}
