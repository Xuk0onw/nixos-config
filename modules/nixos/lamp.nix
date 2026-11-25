{ ... }:

{
  flake.modules.nixos.lamp = { config, pkgs, ... }: {
    # Apache + PHP-FPM
    services.httpd = {
      enable = true;
      adminAddr = "xjle@localhost";
      extraModules = [ "proxy_fcgi" ];
      extraConfig = ''
        <FilesMatch \.php$>
          SetHandler "proxy:unix:${config.services.phpfpm.pools.lamp.socket}|fcgi://localhost"
        </FilesMatch>
      '';
      virtualHosts.localhost = {
        documentRoot = "/var/www";
        listenAddresses = [ "127.0.0.1" ];
        extraConfig = ''
          DirectoryIndex index.php index.html
          <Directory "/var/www">
            AllowOverride All
            Require all granted
          </Directory>
        '';
      };
      virtualHosts."laravel.localhost" = {
        documentRoot = "/var/www/laravel/public";
        listenAddresses = [ "127.0.0.1" ];
        extraConfig = ''
          <Directory "/var/www/laravel/public">
            AllowOverride All
            Require all granted
          </Directory>
        '';
      };
    };

    services.phpfpm.pools.lamp = {
      user = "wwwrun";
      group = "wwwrun";
      settings = {
        "listen.owner" = "wwwrun";
        "listen.group" = "wwwrun";
        pm = "dynamic";
        "pm.max_children" = 10;
      };
    };

    networking.hosts."127.0.0.1" = [ "laravel.localhost" ];

    # MariaDB on 3306
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "laravel" ];
    };

    # MySQL 8 on 3307, hand-rolled second instance
    users.users.mysql8 = { isSystemUser = true; group = "mysql8"; };
    users.groups.mysql8 = { };
    environment.etc."mysql8/my.cnf".text = ''
      [mysqld]
      datadir = /var/lib/mysql8
      port = 3307
      bind-address = 127.0.0.1
      socket = /run/mysqld8/mysqld.sock
      plugin-load-add = auth_socket.so
    '';
    systemd.services.mysql8 = {
      description = "MySQL 8 Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      preStart = ''
        if ! test -e /var/lib/mysql8/mysql; then
          ${pkgs.mysql84}/bin/mysqld --defaults-file=/etc/mysql8/my.cnf \
            --user=mysql8 --datadir=/var/lib/mysql8 --basedir=${pkgs.mysql84} \
            --initialize-insecure
        fi
      '';
      script = ''
        exec ${pkgs.mysql84}/bin/mysqld --defaults-file=/etc/mysql8/my.cnf \
          --user=mysql8 --datadir=/var/lib/mysql8 --basedir=${pkgs.mysql84}
      '';
      postStart = ''
        ${pkgs.mysql84}/bin/mysql -S /run/mysqld8/mysqld.sock -u root \
          -e "ALTER USER root@localhost IDENTIFIED WITH auth_socket;" || true
      '';
      serviceConfig = {
        Type = "notify";
        User = "mysql8";
        Group = "mysql8";
        RuntimeDirectory = "mysqld8";
        ReadWritePaths = [ "/var/lib/mysql8" ];
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
      };
    };

    # Docroot and CLI tools
    users.groups.wwwrun.members = [ "xjle" ];
    systemd.tmpfiles.rules = [
      "d /var/www 2775 wwwrun wwwrun -"
      "d /var/lib/mysql8 0700 mysql8 mysql8 -"
    ];
    environment.systemPackages = [
      pkgs.php
      pkgs.php.packages.composer
      pkgs.nodejs
      (pkgs.writeShellScriptBin "mysql8"
        ''exec ${pkgs.mysql84}/bin/mysql --socket=/run/mysqld8/mysqld.sock "$@"'')
    ];
  };
}
