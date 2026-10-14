{ ... }:

{
  xdg.configFile."rofi/images/g.png".source =
    ./config/rofi/images/g.png;

  xdg.configFile."rofi/launchers/type-6/launcher.sh" = {
    source = ./config/rofi/launchers/type-6/launcher.sh;
    executable = true;
  };

  xdg.configFile."rofi/launchers/type-6/style-7.rasi".source =
    ./config/rofi/launchers/type-6/style-7.rasi;
}
