{ ... }:

{
  xdg.configFile."mango/autostart.sh".source = ./config/mango/autostart.sh;
  xdg.configFile."mango/bind.conf".source = ./config/mango/bind.conf;
  xdg.configFile."mango/config.conf".source = ./config/mango/config.conf;
  xdg.configFile."mango/env.conf".source = ./config/mango/env.conf;
  xdg.configFile."mango/monitor.conf".source = ./config/mango/monitor.conf;
  xdg.configFile."mango/rule.conf".source = ./config/mango/rule.conf;
  xdg.configFile."mango/tag.conf".source = ./config/mango/tag.conf;

  xdg.configFile."mango/scripts/brightness.sh".source =
    ./config/mango/scripts/brightness.sh;
  xdg.configFile."mango/scripts/config_check.sh".source =
    ./config/mango/scripts/config_check.sh;
  xdg.configFile."mango/scripts/exitdim.sh".source =
    ./config/mango/scripts/exitdim.sh;
  xdg.configFile."mango/scripts/idle.sh".source =
    ./config/mango/scripts/idle.sh;
  xdg.configFile."mango/scripts/monitor.sh".source =
    ./config/mango/scripts/monitor.sh;
  xdg.configFile."mango/scripts/restart_wlsunset.sh".source =
    ./config/mango/scripts/restart_wlsunset.sh;
  xdg.configFile."mango/scripts/volume.sh".source =
    ./config/mango/scripts/volume.sh;
}
