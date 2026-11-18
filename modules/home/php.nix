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
      enable = true;
      package = pkgs.mariadb;
    };

    services.httpd = {
      enable = true;
      adminAddr = "admin@example.com";
      enablePHP = true;
    };
  };
}
