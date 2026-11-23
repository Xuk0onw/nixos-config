{ config, inputs, ... }:

{
  flake.modules.nixos.common = {
    imports = (with config.flake.modules.nixos; [
      boot
      variables
      programs
      services
      users
      wallpaperengine
      bluetooth
      font
      network
      optimisation
      audio
      lab
      git
      settings
      home-manager
    ]) ++ [
      inputs.qylock.nixosModules.default
    ];
  };
}
