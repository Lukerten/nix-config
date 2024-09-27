{pkgs, config,lib, ...}:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.battery
      tmuxPlugins.net-speed
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.pass;
        extraConfig = ''
          set @pass-key b
          set @pass-copy-to-clipboard on
        '';
      }
      {
        plugin = tmuxPlugins.tilish;
        extraConfig = ''
          set @tilish-default 'main-vertical'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set @resurrect-strategy-nvim 'session'";
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set @continuum-restore 'on'
          set @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = ''
          set @plugin 'wfxr/tmux-power'
          set @plugin 'wfxr/tmux-net-speed'
          set @tmux_power_theme 'everforest'
          set @tmux_power_date_icon '󰎁'
          set @tmux_power_time_icon '󰥔'
          set @tmux_power_user_icon ''
          set @tmux_power_session_icon ''
          set @tmux_power_show_upload_speed    true
          set @tmux_power_show_download_speed  true
          set @tmux_power_show_web_reachable   true
          set @tmux_power_right_arrow_icon     ''
          set @tmux_power_left_arrow_icon      ''
          set @tmux_power_upload_speed_icon    '󰕒'
          set @tmux_power_download_speed_icon  '󰇚'
          set @tmux_power_prefix_highlight_pos 'R'
        '';
      }
    ];
  };

  programs.tmate = {
    enable = true;
  };

  home.packages = [
    # Open tmux for current project.
    (pkgs.writeShellApplication {
      name = "pux";
      runtimeInputs = [ pkgs.tmux ];
      text = ''
        PRJ="''$(zoxide query -i)"
        echo "Launching tmux for ''$PRJ"
        set -x
        cd "''$PRJ" && \
          exec tmux -S "''$PRJ".tmux attach
      '';
    })
  ];

  xdg.desktopEntries.tmux = {
    name = "Tmux Session";
    genericName = "Terminal Multiplexer";
    comment = "Terminal Multiplexer";
    exec = "tmux new-session -A -s default";
    icon = "utilities-terminal";
    terminal = true;
    type = "Application";
    categories = ["Utility" "TerminalEmulator"];
  };
}
