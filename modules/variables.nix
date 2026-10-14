{ pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "22";
    GTK_THEME = "Adwaita-Black";
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
    nordzy-icon-theme
  ];

  environment.etc."sddm.conf.d/cursor.conf".text = ''
    [Theme]
    CursorTheme=Bibata-Modern-Classic
    CursorSize=22
  '';
}
