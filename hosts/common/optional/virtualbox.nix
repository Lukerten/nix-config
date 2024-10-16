{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      addNetworkInterface = true;
      enableExtensionPack = true;
      enableHardening = true;
      enableWebService = true;
    };
    guest = {
      enable = true;
      dragAndDrop = true;
      clipboard = true;
      seamless = true;
    };
  };
}
