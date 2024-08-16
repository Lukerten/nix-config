{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      format = let
        git = "[$git_branch$git_commit$git_state$git_status](bold blue)";
        cloud = "$aws$gcloud$openstack";
      in ''
        $username$hostname($shlvl)($cmd_duration) $fill ($nix_shell)$custom
        $directory(${git})(- ${cloud}) $fill $time
        $jobs$character(white)
      '';

      fill = {
        symbol = " ";
        disabled = false;
      };

      # Core
      username = {
        format = "[$user]($style)";
        show_always = true;
        style_user = "bold green";
      };
      hostname = {
        format = "[@$hostname](bold yellow) ";
        ssh_only = false;
      };
      shlvl = {
        format = "[$shlvl](bold red) ";
        threshold = 2;
        repeat = true;
        disabled = false;
      };
      cmd_duration = {format = "took [$duration](bold green) ";};

      directory = {
        format = "[$path ](bold blue)([$read_only](bold red))";
        style = "bold blue";
      };
      nix_shell = {
        format = "[($name <- )$symbol]($style) ";
        impure_msg = "";
        symbol = " ";
        style = "bold yellow";
      };
      custom = {
        nix_inspect = let
          excluded = ["kitty" "imagemagick" "ncurses" "user-environment"];
        in {
          disabled = false;
          when = "test -z $IN_NIX_SHELL";
          command = "${(lib.getExe pkgs.nix-inspect)} ${
            (lib.concatStringsSep " " excluded)
          }";
          format = "[($output <- )$symbol]($style) ";
          symbol = " ";
          style = "bold blue";
        };
      };

      character = {
        error_symbol = "[](bold red)";
        success_symbol = "[](bold green)";
        vimcmd_symbol = "[](bold yellow)";
        vimcmd_visual_symbol = "[](bold yellow)";
        vimcmd_replace_symbol = "[](bold yellow)";
        vimcmd_replace_one_symbol = "[](bold yellow)";
      };

      time = {
        format = "\\[[$time](bold blue)\\]";
        disabled = false;
      };

      # Cloud
      gcloud = {
        format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
      };
      aws = {format = "on [$symbol$profile(\\($region\\))]($style)";};

      # Icon changes only \/
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
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
