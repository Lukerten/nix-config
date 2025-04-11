{
  programs.nixvim.plugins = {
    rustaceanvim.settings.server = {
      dap.adapters.lldb = {
        type = "server";
        port = "${''$''}{port}";
        executable = {
          command = "codelldb";
          args = ["--port" "${''$''}{port}"];
        };
      };
    };
  };
}
