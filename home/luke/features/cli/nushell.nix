{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.nushell = {
    inherit (config.home) shellAliases;
    enable = true;
    package = pkgs.nushell;
    plugins = with pkgs.nushellPlugins; [
      units
      net
      gstat
      formats
    ];

    envFile.text = ''
      def create_title [] {
        let prefix = if SSH_TTY in $env {$"[(hostname | str replace -r "\\..*" "")] "}
        let path = pwd | str replace $env.HOME "~"
        ([$prefix, $path] | str join)
      }

      $env.PROMPT_COMMAND = { }
      $env.PROMPT_COMMAND_RIGHT = { }
      $env.PROMPT_INDICATOR = {|| "> " }
      $env.PROMPT_INDICATOR_VI_INSERT = {|| "> " }
      $env.PROMPT_INDICATOR_VI_NORMAL = {|| "| " }
      $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

      $env.config = {
        edit_mode: vi,
        show_banner: false,
        use_kitty_protocol: true,
        shell_integration: {
          osc2: false,
          osc7: true,
          osc8: true,
          osc133: true,
          osc633: true,
          reset_application_mode: true,
        },
        completions: {
          algorithm: "fuzzy",
        },
        history: {
          sync_on_enter: true,
        },
        hooks: {
          pre_prompt: [{
            print -n $"(ansi title)(create_title)(ansi st)"
          }]
        }
      }
      $env.KITTY_SHELL_INTEGRATION = "enabled"
    '';

    # Environment variables
    extraConfig = ''
      $env.PATH = (
        $env.PATH
        | split row (char esep)
        | prepend $"/etc/profiles/per-user/($env.USER)/bin"
        | prepend '/run/current-system/sw/bin/'
        | prepend '/run/wrappers/bin'
        | prepend '/Applications/Docker.app/Contents/Resources/bin/'
      )
    '';
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  xdg.configFile = {
    "carapace/bridges.yaml".text = let
      toYAML = pkgs.lib.generators.toYAML {};
    in
      toYAML {
        nh = "bash";
        hyprctl = "bash";
        pass = "bash";
        nix = "bash";
        man = "bash";
      };
  };
}
