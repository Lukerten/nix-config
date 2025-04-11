{pkgs, ...}: let
  printing-drivers = with pkgs; [
    gutenprint
    gutenprintBin
    postscript-lexmark
    samsung-unified-linux-driver
    splix
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
    cnijfilter2
  ];
in {
  services.printing = {
    enable = true;
    allowFrom = ["all"];
    browsing = true;
    defaultShared = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All
      BrowseProtocols all
    '';
    drivers = printing-drivers;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
