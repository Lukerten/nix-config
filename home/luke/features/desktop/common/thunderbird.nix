let
  defaultSettings = {
    "general.useragent.locale" = "en-US";
    "mail.server.default.check_all_folders_for_new" = true;
    "mail.server.default.delete_model" = 2;
    "mail.server.default.directory-rel" = "[ProfD]Mail";
    "privacy.donottrackheader.enabled" = true;
  };

  defaultUserContent =
    # css
    ''
      *{scrollbar-width: none !important;}
    '';
in {
  programs.thunderbird = {
    enable = true;
    profiles = {
      luke = {
        settings = defaultSettings;
        userContent = defaultUserContent;
        isDefault = true;
      };
      fhe = {
        settings = defaultSettings;
        userContent = defaultUserContent;
      };
    };
  };
}
