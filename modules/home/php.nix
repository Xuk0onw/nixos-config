{ ... }:

{
  flake.modules.homeManager.php = { pkgs, ... }:
    let
      phpDev = pkgs.php84.withExtensions ({ enabled, all }: enabled ++ (with all; [
        bcmath
        curl
        gd
        intl
        mbstring
        pdo_mysql
        pdo_sqlite
        zip
      ]));
    in
    {
      home.packages = [
        phpDev
        phpDev.packages.composer
        (pkgs.laravel.override { php = phpDev; })
      ];
    };

  flake.modules.nixos.php = { pkgs, ... }: {
    services.mysql = {
      enable = false;
      package = pkgs.mariadb;
    };

    services.httpd = {
      enable = false;
      adminAddr = "admin@example.com";
      enablePHP = false;

      virtualHosts.localhost.extraConfig = ''
        Alias /adminer ${pkgs.adminer}/adminer.php
      '';
    };
  };
}
