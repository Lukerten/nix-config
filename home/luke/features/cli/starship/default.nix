{pkgs, lib, config, ...}:{
  programs.starship = {
    enable = true;
    settings = {
      format = let
        hostInfo = "$username$hostname($shlvl)";
        gitInfo = "($git_branch$git_commit$git_state$git_status)";
        extraInfo = "(\${custom.juju})($aws$gcloud$openstack)";
        systemInfo = "($battery$time)";
        localInfo = "$directory";
        nixInfo = "($nix_shell)\${custom.nix_inspect}";
        prompt = "$jobs$character";
      in ''
        ${hostInfo} $fill ${systemInfo}
        ${localInfo}${gitInfo} $fill ${extraInfo}${nixInfo}
        ${prompt}
      '';

      fill = {
        symbol = " ";
      };
      username = {
        format = "[$user]($style)";
        show_always = true;
        style_root = "yellow bold";
      };
      hostname = {
        format = "[@$hostname]($style) ";
        ssh_only = false;
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
        format = "[$symbol($name)]($style)";
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
      custom = {
        nix_inspect = {
          when = "test -z $IN_NIX_SHELL";
          command = lib.getExe (pkgs.writeShellApplication {
            name = "nix-inspect";
            runtimeInputs = with pkgs; [perl gnugrep findutils];
            text = builtins.readFile ./nix-inspect.sh;
          });
          format = "[$symbol($output)]($style)";
          symbol = " ";
          style = "bold blue";
        };
        juju = {
          when = "builtin type -P jj";
          command = lib.getExe (pkgs.writeShellApplication {
            name = "juju-prompt";
            runtimeInputs = [pkgs.yq];
            text = builtins.readFile ./juju-prompt.sh;
          });
          format = "[$symbol($output)]($style)";
          symbol = " ";
          style = "bold fg:208";
        };
      };

      character = {
        error_symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        vimcmd_symbol = "[](bold yellow)";
        vimcmd_visual_symbol = "[](bold cyan)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_replace_one_symbol = "[](bold purple)";
      };

      add_newline = true;
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
