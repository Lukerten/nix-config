{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      copilot-lua.enable = true;
      codecompanion = {
        enable = true;
        settings = {
          strategies = {
            agent = {
              adapter = "copilot";
            };
            chat = {
              adapter = "copilot";
            };
            inline = {
              adapter = "copilot";
            };
          };
        };
      };
      render-markdown = {
        enable = true;
        lazyLoad.settings = {
          ft = ["codecompanion"];
        };
        settings = {
          file_types = [
            "codecompanion"
          ];
        };
      };
    };

    extraPackages = with pkgs; [nodejs-slim];
  };
}
