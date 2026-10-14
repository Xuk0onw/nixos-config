{ config, ... }:

{
  gtk = {
    enable = true;

    font = {
      name = "Hurmit Nerd Font";
      size = 11;
    };

    theme = {
      name = "Space-transparency";
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
    GTK_THEME = "Space-transparency";
    TRACKER_DISABLE = "1";
  };
}
