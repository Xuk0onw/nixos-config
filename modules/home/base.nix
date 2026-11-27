{ config, ... }:

{
  flake.modules.homeManager.base = {
    imports = with config.flake.modules.homeManager; [
      user
      fish
      tmux
      btop
      nixvim
      bash
      cava
      fastfetch
      yazi
      home-programs
      home-services
      gtk-qt
      noctalia
      dms
      mango
    ];
  };
}
