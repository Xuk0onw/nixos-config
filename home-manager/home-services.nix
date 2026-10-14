{ ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/xjle/Music";
    network.startWhenNeeded = true;
  };
}
