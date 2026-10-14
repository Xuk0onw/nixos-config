
{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    font = {
      name = "Hurmit Nerd Font";
      size = 11;
    };

    theme = {
      name = "Orchis-Purple-Dark";
    };

    gtk4.theme = config.gtk.theme;

    iconTheme = {
      name = "Tela-circle-dark";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Orchis-Purple-Dark";
    TRACKER_DISABLE = "1";
  };

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
