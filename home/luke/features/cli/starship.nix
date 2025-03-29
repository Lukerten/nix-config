#"─"
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = let
        lower = "\${custom.lower}";
        upper = "\${custom.upper}";
        systemInfo = "$hostname($shlvl)$nix_shell$battery$time";
        locationInfo = "$directory($git_branch$git_commit$git_state$git_status)";
        prompt = "$jobs$character";
      in ''
        ${upper} ${locationInfo}$fill ${systemInfo}
        ${lower} ${prompt}
      '';

      add_newline = true;
      fill = {
        symbol = "─";
        style = "white";
      };
      username = {
        format = "[$user]($style)";
        show_always = true;
        style_root = "yellow bold";
      };
      hostname = {
        format = "[@$hostname]($style) ";
        ssh_only = true;
        style = "bold green";
      };
      shlvl = {
        format = "[$shlvl]($style) ";
        style = "bold cyan";
        threshold = 2;
        repeat = true;
        disabled = false;
      };
      directory = {
        format = "[$path]($style)( [$read_only]($read_only_style)) ";
      };
      nix_shell = {
        format = "[($name) $symbol]($style)";
        impure_msg = "";
        symbol = " ";
        style = "bold blue";
      };
      battery = {
        format = "[$symbol$percentage%]($style)";
        full_symbol = "󰁹 ";
        charging_symbol = "󰂄 ";
        discharging_symbol = "󰂃 ";
        unknown_symbol = "󰁹 ";
        empty_symbol = "󰂎 ";
      };
      time = {
        format = "[$time]($style)";
        style = "bold yellow";
        disabled = false;
        time_format = "%H:%M";
      };
      character = {
        error_symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        vimcmd_symbol = "[](bold yellow)";
        vimcmd_visual_symbol = "[](bold cyan)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_replace_one_symbol = "[](bold purple)";
      };
      custom = {
        upper = {
          when = "true";
          format = "[╭─]($style)";
          style = "white";
        };
        middle = {
          when = "true";
          format = "[├─]($style)";
          style = "white";
        };
        lower = {
          when = "true";
          format = "[╰─]($style)";
          style = "white";
        };
      };

      gcloud.format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
      aws.format = "on [$symbol$profile(\\($region\\))]($style)";
      aws.symbol = " ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elm.symbol = " ";
      elixir.symbol = "";
      gcloud.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      nim.symbol = "󰆥 ";
      nodejs.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = "";
      swift.symbol = "󰛥 ";
      terraform.symbol = "󱁢";
    };
  };
}
