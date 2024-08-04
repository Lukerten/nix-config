{
  writeShellScriptBin,
  opensc,
}:
writeShellScriptBin "cm4all-vpn" ''
  #!/bin/bash
  OVPN_VERB=0

  if [[ "$1" = "-v"  ]]
  then
  	set -x
  	OVPN_VERB=4
  fi

  VPN_SOCKET="/var/run/openvpn.sock"
  DNS="172.30.37.1"

  function detect_os () {
    if [[ $OSTYPE == 'linux'* ]]; then
      echo "Detected Linux"
      OS="Linux"
      PKCS11=${opensc}/lib/opensc-pkcs11.so
      OPENVPN="openvpn"
      RESOLV_CONF=/etc/resolv.conf
      RESOLV_CONF_CONTENT=$(cat $RESOLV_CONF)
      # checking if /etc/resolv.conf is a symlink
      RESOLV_LINK=0
      if [ -L /etc/resolv.conf ] ; then
        RESOLV_LINK=1
        LINK_PATH=$(readlink /etc/resolv.conf)
        rm -f /etc/resolv.conf
        cat $LINK_PATH > /etc/resolv.conf
      fi
    elif [[ $OSTYPE == 'darwin'* ]]; then
      echo "Detected MacOS"
      OS="Mac"
      OPENVPN="openvpn"
      if [[ -f "/Library/OpenSC/lib/opensc-pkcs11.so" ]]
      then
        PKCS11="/Library/OpenSC/lib/opensc-pkcs11.so"
      else
        echo "File not found: opensc-pkcs11.so"
        exit 1
      fi
    else
      echo "Unsupported OS detected"
      OS="Unknown"
      exit 1
    fi
  }

  function write_ca () {
    echo "-----BEGIN CERTIFICATE-----
  MIIEYzCCBAigAwIBAgIUcm0YSoWbOilfCwnTO6FAG37+7Z4wCgYIKoZIzj0EAwIw
  gbYxCzAJBgNVBAYTAkRFMR8wHQYDVQQIExZOb3J0aCBSaGluZS1XZXN0cGhhbGlh
  MRAwDgYDVQQHEwdDb2xvZ25lMR4wHAYDVQQKExVDb250ZW50IE1hbmFnZW1lbnQg
  QUcxJDAiBgNVBAsTG0xpbnV4IFN5c3RlbSBBZG1pbmlzdHJhdGlvbjEuMCwGA1UE
  AxMlQ29udGVudCBNYW5hZ2VtZW50IEFHIC0gTGludXggUk9PVCBDQTAeFw0yMTEw
  MTgxMzIyMDBaFw0zNjEwMTQxMzIyMDBaMHgxCzAJBgNVBAYTAkRFMQwwCgYDVQQI
  EwNOUlcxEDAOBgNVBAcTB0NvbG9nbmUxFDASBgNVBAoTC0NNNEFsbCBHbWJIMRYw
  FAYDVQQLEw1JVCBPcGVyYXRpb25zMRswGQYDVQQDExJDTTRBbGwgR21iSCBWUE4g
  Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC1yefHsqgXP1Ew1q50
  EXn4NvTQz6LCdwXmz8b68T8DF8o2jbtv0NucqPsEe/iQTqh/R4TEQhGeJ23vBuPg
  tYInk2ygkY367m51CGUFfetH4I1tG2F2brdZ/+kkGsfNYdovxNoLXPvbm781Ykfo
  6uuwVu6ksMVKqxmYivHd2e7XA0xj9my82L+5/LRa56vw/ZtrvZXPl3wKoVvUjcve
  KX1vFcJnJbc09x00s4Tysys5Oks7jfAkG5suPxVWijZUgqOKZb20dLAMxfIAJltP
  SbZdhLIlIYzRirahzuQo9dScYWB/cNt/HzaqFeBWxoMHPbKWLFjWY4/LDb+dFg25
  haL6jr5Mhp9Sa+ZJQQWOWkhyeCBXS4PMCFmIhPMSxKwDd/BZB4LjO8f0dALAQfzg
  /aJ/t5Ucw/dMOunAwFyhnyonA9wVAhV5V43HNaSGybr8UJ831WEvKvQ2r+U2050A
  ZwCIFYGxWsR4pP6WQdm5T/xuArFVYPA14GhZ7V/BVfRdG7uFOq4qbTShIPuH4Ck9
  4ylBLkuBO3QK/XZEU3pqxvH8IjfoVPnX2qXSRSZzJfWMMJF4V7S2d5fzjss74R5R
  fXe5dG2/8jiRPbrQP3JdrBiZH75gQ/lyMZagg6FWQ311l8rL1K5VCfmT8J0sFo+2
  fQQfo7w4+mm+58Pu2cRNf5+8dwIDAQABo2YwZDAOBgNVHQ8BAf8EBAMCAYYwEgYD
  VR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUpO9/+BUKS+o8x6albZZ9JFtCBr4w
  HwYDVR0jBBgwFoAUH7bKwr5jTmDsF8oMwjQv6pL5FoowCgYIKoZIzj0EAwIDSQAw
  RgIhAN4FQN5ywJVTkICwetuP+9H6yZNtVDL0egp8odOiI7lCAiEAgmfPmboiERyb
  BzIN+4aNSn93hbrBnQ9sJcIAV0PFXAw=
  -----END CERTIFICATE-----
  -----BEGIN CERTIFICATE-----
  MIICsjCCAligAwIBAgIUQbgfV/Y0iw9362MYgPaxj3ymznAwCgYIKoZIzj0EAwIw
  gbYxCzAJBgNVBAYTAkRFMR8wHQYDVQQIExZOb3J0aCBSaGluZS1XZXN0cGhhbGlh
  MRAwDgYDVQQHEwdDb2xvZ25lMR4wHAYDVQQKExVDb250ZW50IE1hbmFnZW1lbnQg
  QUcxJDAiBgNVBAsTG0xpbnV4IFN5c3RlbSBBZG1pbmlzdHJhdGlvbjEuMCwGA1UE
  AxMlQ29udGVudCBNYW5hZ2VtZW50IEFHIC0gTGludXggUk9PVCBDQTAeFw0xODA2
  MjAxNTAzMDBaFw00ODA2MTIxNTAzMDBaMIG2MQswCQYDVQQGEwJERTEfMB0GA1UE
  CBMWTm9ydGggUmhpbmUtV2VzdHBoYWxpYTEQMA4GA1UEBxMHQ29sb2duZTEeMBwG
  A1UEChMVQ29udGVudCBNYW5hZ2VtZW50IEFHMSQwIgYDVQQLExtMaW51eCBTeXN0
  ZW0gQWRtaW5pc3RyYXRpb24xLjAsBgNVBAMTJUNvbnRlbnQgTWFuYWdlbWVudCBB
  RyAtIExpbnV4IFJPT1QgQ0EwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAAS9zOCZ
  b/5XbgIWsjBtSAw0mcPfkD4wRcwwBU0WvwLJdrFb8lB+eK8rweo+ox2K3DKPGd6L
  y03fD4TsrS5HhyQ1o0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB
  /zAdBgNVHQ4EFgQUH7bKwr5jTmDsF8oMwjQv6pL5FoowCgYIKoZIzj0EAwIDSAAw
  RQIhALo2IiO0z4UK33Y9w8sc27QB93BHXnBGS9zLISPd6ixnAiBsOefKPVYTQ6i3
  GF+66E0l7PknFEjVhXtbRLk6I1ATGw==
  -----END CERTIFICATE-----" > $1
  }

  function poll_vpn_state () {
    echo "state" |socat - unix-connect:/var/run/openvpn.sock |grep -v '^>' |sed '1q;d'| cut -d ',' -f2
  }

  function poll_vpn_state_user () {
    echo "state" |socat - unix-connect:/var/run/openvpn.sock
  }

  function check_status() {
    while true; do
      if [ ! -S "$VPN_SOCKET" ]; then
        exit 0
      fi
      echo "state" |socat - unix-connect:/var/run/openvpn.sock |grep '^>'  |sed '2q;d' |grep "PASSWORD:Need 'Auth' username/password" > /dev/null
      if [[ $? -eq 0 ]]; then
        echo "username \"Auth\" $VPN_USER" |$SOCAT > /dev/null
        echo "password \"Auth\" '$VPN_PASS'" |$SOCAT > /dev/null
      fi

      if [[ $(poll_vpn_state) != "CONNECTED" ]]; then
        echo "Connection to server lost.. Trying to reconnect."
      fi
      sleep 15
    done
  }

  function auth_vpn () {
    SOCAT="socat - unix-connect:/var/run/openvpn.sock"
    echo -n "Username: "; read VPN_USER
    echo -n "Password: "; read -s VPN_PASS; echo
    echo -n "Yubikey Token: "; read -s VPN_TOKEN; echo

    pkcs11-tool -l -t -p$VPN_TOKEN
    if [[ $? -ne 0 ]]; then
      echo "WRONG PIN!"
      stop_vpn
    fi
    echo $VPN_user
    echo "username \"Auth\" $VPN_USER" |$SOCAT > /dev/null
    echo "password \"Auth\" '$VPN_PASS'" |$SOCAT > /dev/null
    echo "Connecting to VPN Server"

    until [[ $(poll_vpn_state) == "AUTH" ]]; do
    echo "Waiting for OpenVPN to ask for our token."
      sleep 2;
    done
    echo "password \"$VPN_USER token\" $VPN_TOKEN" |socat - unix-connect:/var/run/openvpn.sock > /dev/null
  }

  function analysis () {
    echo "VPN STATE"
    poll_vpn_state
    if [[ $OSTYPE == 'linux'* ]]; then
      echo "Network config"
      ip a s
      echo "Routing Table"
      ip r s
    elif [[ $OSTYPE == 'darwin'* ]]; then
      echo "Network config"
      ifconfig -a
      echo "Routing Table"
      netstat -rn
    fi
    echo "Resolv.conf"
    cat /etc/resolv.conf
  }

  function generate_config () {
    PIV=$($OPENVPN --show-pkcs11-ids $PKCS11 |grep Serialized |awk '{ print $3 }')
    PORT="1194"
    CIPHER="AES-256-CBC"
    AUTH="SHA1"
    REMOTE="195.14.246.137"
    PROTO="tcp"
    echo "$OPENVPN --management $VPN_SOCKET unix --management-query-passwords --client --data-ciphers $CIPHER --cipher $CIPHER --auth $AUTH --remote $REMOTE --dev tun --port $PORT --proto $PROTO --ca $1 --auth-user-pass --pkcs11-providers $2 --pkcs11-id $PIV --remote-cert-tls server --verb $OVPN_VERB --tun-mtu 1500 --mssfix --auth-nocache"
  }

  function generate_resolvconf () {
    if [[ $OS == "Linux" ]]
    then
      chattr -i $RESOLV_CONF; chmod 644 $RESOLV_CONF
      echo -e "nameserver $DNS\nsearch intern.cm-ag\nnameserver 1.1.1.1" > $RESOLV_CONF
      chmod 444 $RESOLV_CONF && chattr +i $RESOLV_CONF
      if [ $? -ne 0 ]
      then
        echo "Failed to modify resolv.conf. Restoring original file."
        chattr -i $RESOLV_CONF; chmod 644 $RESOLV_CONF
        echo "$RESOLV_CONF_CONTENT" > $RESOLV_CONF
        return 1
      fi
      return 0
    elif [[ $OS == "Mac" ]]; then
      while read SERVICE; do networksetup -setdnsservers "$SERVICE" "$DNS"; done < <(networksetup listallnetworkservices |grep -v '*')
    fi
  }

  function stop_vpn () {
    echo -e "\n-----------------------"
    echo "Stopping VPN"
    killall openvpn || true
    echo "Restoring original resolv.conf"
    # different ways of restoring depending to the filetyp of /etc/resolv.conf
    if [[ $OS == "Linux" ]] ; then
      if [ $RESOLV_LINK -eq 1 ] ; then
        chattr -i $RESOLV_CONF
        rm -f $RESOLV_CONF
        ln -s $LINK_PATH /etc/resolv.conf
      elif [ $RESOLV_LINK -eq 0 ] ; then
        chattr -i $RESOLV_CONF
        chmod 644 $RESOLV_CONF
        echo "$RESOLV_CONF_CONTENT" > $RESOLV_CONF
      fi
    elif [[ $OS == "Mac" ]] ; then
      while read SERVICE; do networksetup -setdnsservers "$SERVICE" "Empty"; done < <(networksetup listallnetworkservices |grep -v '*')
    fi
    exit 0
  }

  function main () {
    trap stop_vpn SIGINT SIGHUP SIGQUIT SIGKILL SIGTERM
    if [[ `id -u` -ne 0 ]]; then
      echo "Script must be run with sudo / as root"
      exit 1;
    fi

    echo "Setting up VPN connection"
    detect_os
    if [[ $OS == "Linux" ]]; then
      if [[ -z $RESOLV_CONF || -z $RESOLV_CONF_CONTENT ]]; then
        echo "Failed to parse resolv.conf. Exiting"
        exit 1
      fi
    fi
    echo "Locating PKCS11 provider library"

    echo "Trying to detect Yubikey..."
    ykman piv info > /dev/null

    if [[ $? -ne 0 ]]; then
      exit 1;
    fi
    TMP=$(mktemp)

    write_ca $TMP
    VPN=$(generate_config $TMP $PKCS11)

    echo "Connecting to VPN."
    $VPN &
    auth_vpn && echo -n "Setting up VPN Connection..."
    TRY=0
    until [[ $(poll_vpn_state) == "CONNECTED" ]]; do
      echo -n "..."
      sleep 5;
      # Super Dirty Workaround for MacOS. It looks like OpenVPN is not happy, when it receives the token. That's why we gonna give it him every 5 secs.
      echo "password \"$VPN_USER token\" $VPN_TOKEN" |socat - unix-connect:/var/run/openvpn.sock > /dev/null
      ((TRY=$TRY+1))
      if [[ $TRY -gt 12 ]]
      then
        echo
        echo "Connection timeout reached. Check your credentials and Yubikey pin. If problem persists send the following output to the OPS team for analysis:"
        echo "----------------------------------------------------"
        analysis
        stop_vpn
      fi

    done
    echo "Creating resolv.conf"
    generate_resolvconf
    if [[ $? > 0 ]]; then
      stop_vpn
      exit 1
    fi
    echo "VPN connection up and running. Hit CTRL+C to disconnect."

    check_status &
    while true; do
      read USER_INPUT
      case $USER_INPUT in
      "status")
        poll_vpn_state
      ;;
      *)
      echo "Unknown command"
      ;;
    esac
    done
  }

  main
''
