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
}
