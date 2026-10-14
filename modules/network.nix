{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";

    dispatcherScripts = [
      {
        source = pkgs.writeShellScript "nm-ignore-dhcp-dns" ''
          #!/bin/sh

          if [ "$2" = "up" ] && [ -n "$CONNECTION_UUID" ]; then
            TYPE="$(nmcli -g connection.type connection show "$CONNECTION_UUID" 2>/dev/null)"

            if [ "$TYPE" = "802-11-wireless" ]; then
              nmcli connection modify "$CONNECTION_UUID" \
                ipv4.ignore-auto-dns yes \
                ipv6.ignore-auto-dns yes

              nmcli device reapply "$1" 2>/dev/null || true
            fi
          fi
        '';
        type = "basic";
      }
    ];
  };

  services.resolved = {
    enable = true;

    settings.Resolve = {
      DNS = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
      ];

      DNSOverTLS = "yes";
    };
  };
}
