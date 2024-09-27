{pkgs, lib, config, ...}:{
  programs.starship = {
    enable = true;
    settings = {
      format = let
        hostInfo = "$username$hostname($shlvl)($time)";
        localInfo = "$directory($git_branch$git_commit$git_state$git_status)";
        prompt = "\n";
      in ''
        ${hostInfo}
        ${localInfo}
        ${prompt}
      '';
      username = {
        format = "[$user]($style)";
        show_always = true;
        style_root = "yellow bold";
      };
      hostname = {
        format = "[@$hostname]($style)";
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
      add_newline = true;

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
