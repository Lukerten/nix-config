{
  config,
  inputs,
  ...
}: {
  imports = [
    ./roundcube.nix
    ./traefik.nix
    inputs.nixos-mailserver.nixosModules.mailserver
  ];

  services.dovecot2.sieve.extensions = ["fileinto"];

  mailserver = rec {
    enable = true;
    fqdn = "mail.lukerten.de";
    sendingFqdn = "sanctity.lukerten.de";
    useFsLayout = true;
    certificateScheme = "acme-nginx";
    localDnsResolver = false;
    domains = [
      "lukerten.de"
    ];

    # Login Accounts
    loginAccounts = {
      "lucas.brendgen@lukerten.de" = {
        hashedPasswordFile = config.sops.secrets.lucas-brendgen-mail-password-hashed.path;
        aliases = map (d: "@" + d) domains;
      };
      "grafana@lukerten.de" = {
        hashedPasswordFile = config.sops.secrets.grafana-mail-password-hashed.path;
        aliases = map (d: "@" + d) domains;
      };
    };

    # Mailbox Setup
    mailboxes = {
      Archive = {
        auto = "subscribe";
        specialUse = "Archive";
      };
      Drafts = {
        auto = "subscribe";
        specialUse = "Drafts";
      };
      Sent = {
        auto = "subscribe";
        specialUse = "Sent";
      };
      Junk = {
        auto = "subscribe";
        specialUse = "Junk";
      };
      Trash = {
        auto = "subscribe";
        specialUse = "Trash";
      };
    };

    mailDirectory = "/srv/mail/vmail";
    sieveDirectory = "/srv/mail/sieve";
    dkimKeyDirectory = "/srv/mail/dkim";
  };
}
