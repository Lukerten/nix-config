{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.helix = {
    extraPackages = with pkgs; [helix-gpt];

    languages = {
      language-server.helix-gpt = {
        command = "helix-gpt";
        args = [
          "--handler"
          "copilot"
          # "--copilotApiKey"
          # "$(cat ${config.sops.secrets.copilot_api_key.path})"
        ];
      };
    };
  };

  sops.secrets.copilot_api_key = {
    sopsFile = ../../../secrets.yaml;
  };

  programs.fish.interactiveShellInit = ''
    # Load copilot Api key as env variable on startup
    set -x COPILOT_API_KEY $(cat ${config.sops.secrets.copilot_api_key.path})
  '';
}
