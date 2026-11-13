{ ... }:

{
  flake.modules.homeManager.home-services = { ... }:


  {
    services.mpd = {
      enable = true;
      musicDirectory = "/home/xjle/Music";
      network.startWhenNeeded = true;
    };
  };
}
