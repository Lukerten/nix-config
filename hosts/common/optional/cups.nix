{pkgs, ...}: let
  printing-drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.hplip
    pkgs.hplipWithPlugin
    pkgs.postscript-lexmark
    pkgs.samsung-unified-linux-driver
    pkgs.splix
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
    pkgs.cnijfilter2

  ];
in {
  services.printing = {
  enable = true;
  allowFrom = [ "all" ];
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
