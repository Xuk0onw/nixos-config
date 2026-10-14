
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    orchis-theme
    qt6Packages.qtstyleplugin-kvantum
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    adwaita-icon-theme
    hicolor-icon-theme
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    tela-icon-theme
    tela-circle-icon-theme
  ];
}
